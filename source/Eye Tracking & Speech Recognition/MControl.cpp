#include "CSpeech.h"					//Microsoft HTK Speech Recognition Toolkit
#include "opencv2/objdetect/objdetect.hpp"		//Opencv
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv/AutoIt3.h"				//AutoIt Linker
#include "iostream"
#include "Windows.h"					//Thread
#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "string.h"

using namespace std;
using namespace cv;

#define PI 3.14159265;

//init variables: Viola-Jones face detection
String face_cascade_name = "haarcascade_frontalface_alt.xml";			//pretrained face model
String eyes_cascade_name = "haarcascade_eye_tree_eyeglasses.xml";		//pretrained eye model
CascadeClassifier face_cascade;								//load cascade class for classification
CascadeClassifier eyes_cascade;
string window_name = "Capture - Face detection";
int eyesCloseCounter = 0;									//eye close duration until triggering keyboard

//init variables: AutoIt mouse control
int mx = AU3_MouseGetPosX();								//current mouse position x
int my = AU3_MouseGetPosY();								//current mouse position y
char  wstrlist[3][20] = {"osk-l.exe","osk-m.exe","osk-s.exe"};				//on screen keyboard .exe list
int kbCount = 0;										//on screen keyboard size (0: large, 1: small, 2: medium)

//face/eye detection and display result in realtime
void detectAndDisplay(Mat raw_frame){
	std::vector<Rect> faces;								//face bounding box
	Mat frame_gray, frame;
	flip(raw_frame, frame, 1);								//mirror capture frame for intuitive direction
	cvtColor(frame, frame_gray, CV_BGR2GRAY);				//convert to grayscale
	equalizeHist(frame_gray, frame_gray);						//normalize by histogram equalization
	
	//face detection
	face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE,	\ 
					         Size(frame_gray.rows/3, frame_gray.rows/3));
	
	//draw red reference ellipse (half size of vga webcam)
	Point centerEllipse(320, 240);
	ellipse(frame, centerEllipse, Size(50, 50), 0, 0, 360, Scalar(0, 0, 255), 2, 8, 0);

	//if found face(s)
	if(faces.size()){
		Rect face = faces[0]							//use first face	
		float faceCenterX = face.x + (face.width * 0.5);
		float faceCenterY = face.y + (face.height * 0.5);
		Point faceCenter(faceCenterX, faceCenterY);				//center of face		
		//draw face ellipse
		ellipse(frame, faceCenter, Size(face.width*0.5, face.height*0.5), 0, 0, 360, Scalar(255, 0, 255), 2, 8, 0);
		
		//crop fram into face rectangle
		Mat faceROI = frame_gray(face);
		
		//eye detection on face area
		std::vector<Rect> eyes;
		eyes_cascade.detectMultiScale(faceROI, eyes, 1.1, 2, 0 |CV_HAAR_SCALE_IMAGE, Size(30,30));
		
		double eyesMeanCenterX = 0, eyesMeanCenterY = 0;
		for(int i = 0; i<eyes.size(); i++){
			//draw circle around the eyes
			double eyeCenterX = face.x + eyes[i].x + (eyes[i].width * 0.5);
			double eyeCenterY = face.x + eyes[i].x + (eyes[i].height * 0.5);
			Point center(eyeCenterX, eyeCenterY);
			circle(frame, center, 10.0, Scalar(255, 0, 0), 3, 8, 0);
			
			//calculate mean position of both eyes
			eyesMeanCenterX += eyeCenterX;
			eyesMeanCenterY += eyeCenterY;
		}
				
		float relativeCenterX = eyesMeanCenterX - centerEllipse.x		//center of eyes relative to reference ellipse
		float relativeCenterY = eyesMeanCenterY - centerEllipse.y

		//calculate angle relative to reference ellipse
		double theta = atan(-relativeCenterY/relativeCenterX) * (180/PI);
		
		//prevent sin function bug for negative theta
		if(relativeCenterX>0 && theta<0)					
			theta += 360;							//convert negative theta to positive
		theta *= (PI/180.0);	

		//calculate radius by sqrt(X^2 + Y^2) for mouse moving speed
		double radius = sqrt(pow(eyesMeanCenterX,2) + pow(eyesMeanCenterY,2));
		
		//if eyes are far enough from reference ellipse
		if(radius>50){
			//draw green line to indicate mouse move distance and direction
			line(frame, centerEllipse, faceCenter, Scalar(255, 0, 0), 1, 8, 0);
		
			//get current mouse position
			mx = AU3_MouseGetPosX();
			my = AU3_MouseGetPosY();
			
			//move to the new position
			AU3_MouseMove(mx + radius*cos(theta), my - radius*sin(theta), 0);
		}
		//otherwise, check for eye close condition
		else {
			//if eyes are not found (eye close)
			if(eyes.size()==0){;
				if(eyesCloseCounter<30)
					eyesCloseCounter++;
				else {
					//close previous on screen keyboard
					AU3_ProcessClose(L"osk-l.exe");
					AU3_ProcessClose(L"osk-m.exe");
					AU3_ProcessClose(L"osk-s.exe");
					kbCount%=3;
					
					//call on screen keyboard
					char buff[100];
					sprintf(buff,"start %s",wstrlist[kbCount++]);
					system(buff);
					eyesCloseCounter = 0;
				}
			}
			else							//found eyes
				eyesCloseCounter = 0;			//reset eye close duration to 0
		}
	}
	
	imshow(window_name, frame);
}

DWORD WINAPI speechThread(LPVOID iValue){
	//Initiate HTK Speech Recognition Toolkit
	CuSpeechRecognition HTKHandler(L"../Grammar/clickLeft.xml", HandlerRoutine);
	LPWSTR text;
	char tmp[50];
	int confident;
	while(true){
		if(HTKHandler.recognize(text, confident)){		//successfully capture word
			if(wcsstr(text, L"left"))				//mouse click left
				AU3_MouseClick( L"LEFT", AU3_MouseGetPosX(), AU3_MouseGetPosY(), 1, 0);
			else if(wcsstr(text, L"right")){			//mouse click right
				AU3_MouseClick(L"RIGHT", AU3_MouseGetPosX(), AU3_MouseGetPosY(),1,0);
			else if(wcsstr(text, L"zoom"))			//call zoom.exe
				system("start zoom.exe");
			else if(wcsstr(text, L"key"))			//call on screen keyboard
				system("start osk-l.exe");
			else if(wcsstr(text, L"pad"))
				system("start hotpad.exe");
			else if(wcsstr(text, L"stop")){
				AU3_ProcessClose(L"osk-l.exe");	//kill on screen keyboard
				AU3_ProcessClose(L"osk-m.exe");
				AU3_ProcessClose(L"osk-s.exe");
				AU3_ProcessClose(L"zoom.exe");	//kill zoom
				AU3_ProcessClose(L"monitor.exe");	//kill monitor closer
			}
			else if(wcsstr(text, L"close"))
				AU3_WinKill(L"[ACTIVE]", L"");		//kill active process
		}
	}
	return 0;
}

int main(int argc, const char** argv){
	system("start monitor.exe");					//auto turn of monitor after 5 minute of inactivity
	
	//call speechThread() in background to handle speech command	
	DWORD dwGenericThread;
	long numThread = 10;						//at least 10 threads to guarantee performance
	HANDLE hThread = CreateThread(NULL, 0, speechThread, &numThread, 0, &dwGenericThread);
	if(hThread == NULL){						//not enough resource / thread crash
		DWORD dwError = GetLastError();
		cout << "Error: creating thread " << dwError << endl ;
		return -1;
	}
	WaitForSingleObject(hThread,1);
	
	//load pretrain face model
	if(!face_cascade.load(face_cascade_name)){
		cout << " Error: loading face model" << endl; 
		return -1; 
	}
	//load pretrain eye model
	if(!eyes_cascade.load(eyes_cascade_name)){ 
		cout << " Error: loading eye model" << endl; 
		return -1;
	}

	//begin camera capture
	namedWindow(window_name, CV_WINDOW_NORMAL);
	CvCapture* capture = cvCaptureFromCAM(-1);
	Mat frame;
	frame.setTo(CV_CAP_PROP_FRAME_HEIGHT, 30);
	if(capture){								//successfully attach camera
		while(true){
			//apply classifier to the frame
			frame = cvQueryFrame(capture);
			if(!frame.empty())
				detectAndDisplay(frame);
			else{ 
				cout << " Error: capturing frame" << endl; 
				break;
			}
			
			//emergency stop with "c"
			int c = waitKey(10);
			if((char)c == 'c') 
				break;
		}
	}
	return 0;
}
