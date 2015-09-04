#include "CSpeech.h"
#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv/AutoIt3.h"
#include "iostream"
#include "Windows.h"
#include "stdio.h"
#include "stdlib.h"
#include"math.h"
#include <string.h>

using namespace std;
using namespace cv;
#define PI 3.14159265;
void detectAndDisplay( Mat frame );
/** Global variables */
//-- Note, either copy these two files from opencv/data/haarscascades to your current folder, or change these locations
String face_cascade_name = "haarcascade_frontalface_alt.xml";
String eyes_cascade_name = "haarcascade_eye_tree_eyeglasses.xml";
CascadeClassifier face_cascade;
CascadeClassifier eyes_cascade;
string window_name = "Capture - Face detection";
RNG rng(12345);
int mx = AU3_MouseGetPosX();
int my = AU3_MouseGetPosY();
char   wstrlist[3][1000]={"osk-l.exe","osk-m.exe","osk-s.exe"};
int kbCount = 0;
DWORD WINAPI StartThread(LPVOID iValue)
{
    
      CuSpeechRecognition sr(L"../Grammar/clickLeft.xml",HandlerRoutine);
     
	  LPWSTR text;
	  char tmp[50];
		int confident;
		while(true){
			if(sr.recognize(text,confident)){
				std::wcout << text << " (" << confident << ") " << std::endl;
				
				if(wcsstr(text,L"left")){
					LPWSTR   wstr2= L"LEFT";
					AU3_MouseClick(wstr2, AU3_MouseGetPosX(), AU3_MouseGetPosY(),1,0);
				}else if(wcsstr(text,L"right")){
					LPWSTR   wstr2= L"RIGHT";
					//system("start zoom.exe");
					AU3_MouseClick(wstr2, AU3_MouseGetPosX(), AU3_MouseGetPosY(),1,0);
				}else if(wcsstr(text,L"up")){
					
					system("start zoom.exe");
				}else if(wcsstr(text,L"down")){
					system("start osk-l.exe");
				}else if(wcsstr(text,L"stop")){
					LPWSTR   wstr2= L"[ACTIVE]";
					LPWSTR   wstr3= L"osk-l.exe";
					 AU3_WinKill(wstr2,L"");
					 AU3_ProcessClose(L"osk-l.exe");
			         AU3_ProcessClose(L"osk-m.exe");
			         AU3_ProcessClose(L"osk-s.exe");
				}
			}

		}
      return 0;
}
int main( int argc, const char** argv )
{   TCHAR pwd[MAX_PATH];
GetCurrentDirectory(MAX_PATH,pwd);
char jbuff[5000];
for (int i=0;i<100;i++) {
	if ((char)pwd[i] == '\0') {jbuff[i] = (char)(pwd[i]); break;}
		jbuff[i] = (char)(pwd[i]);
}

	char jumpbuf[100000];
	strcpy(jumpbuf, "PATH=");
	strcat(jumpbuf,getenv("PATH"));
	strcat(jumpbuf,";");
	strcat(jumpbuf,(char*)jbuff);
	strcat(jumpbuf,";");
	//printf("%s\n\n\n",jumpbuf);	
	putenv(jumpbuf);
	
	HINSTANCE hGetProcIDDLL = LoadLibrary("../"); 

  CvCapture* capture;
  Mat frame;
        HANDLE hThread1,hThread2;
      DWORD dwGenericThread;
  
	  long num = 1000;
      hThread1 = CreateThread(NULL,0,StartThread,&num,0,&dwGenericThread);
      if(hThread1 == NULL)
      {
            DWORD dwError = GetLastError();
            cout<<"SCM:Error in Creating thread"<<dwError<<endl ;
            return 0;
       }
	 
     WaitForSingleObject(hThread1,1);
  namedWindow(window_name, CV_WINDOW_NORMAL );
 
  frame.setTo(CV_CAP_PROP_FRAME_HEIGHT,30);
  	
  //-- 1. Load the cascades
 
  {
	  TCHAR pwd[MAX_PATH];
		GetCurrentDirectory(MAX_PATH,pwd);
		printf("cwd%s\n", pwd);
  }
  
  if( !face_cascade.load( face_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; };
if( !eyes_cascade.load( eyes_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; };
 //system("pause");
  //-- 2. Read the video stream
  capture = cvCaptureFromCAM( -1 );
 
  if( capture )
  {
    while( true )
	{
		
      frame = cvQueryFrame( capture );

      //-- 3. Apply the classifier to the frame
      if( !frame.empty() )
       { detectAndDisplay( frame ); }
      else
       { printf(" --(!) No captured frame -- Break!"); break; }
	   
      int c = waitKey(10);
      if( (char)c == 'c' ) { break; }

    }
  }
  return 0;
}


int CenX = 305;
int CenY = 270;
int timeCounter =0;
void detectAndDisplay( Mat frame_t )
{
	Point cenO(CenX,CenY);
   std::vector<Rect> faces;
   Mat frame_gray;
    Mat frame;
   flip(frame_t,frame,1);

   cvtColor( frame, frame_gray, CV_BGR2GRAY );
   equalizeHist( frame_gray, frame_gray );
   
   //-- Detect faces
  face_cascade.detectMultiScale( frame_gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, Size(frame_gray.rows/3,frame_gray.rows/3 ) );
  cout<<"run"<<endl;
   ellipse( frame, cenO, Size( 50, 50), 0, 0, 360, Scalar( 0, 0, 255 ), 2, 8, 0 );
  // for( int i = 0; i < (int)faces.size(); i++ )
   
   if(faces.size()){  
	int i=0;
      Point center( faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5 );
	  double theta = atan((double)(-faces[i].y- faces[i].height*0.5+cenO.y)/(double)(faces[i].x+faces[i].width*0.5-cenO.x))* 180 /PI;

	 if(faces[i].x+faces[i].width*0.5-cenO.x>0&&theta<0)theta = 360 + theta;
	 else if(faces[i].x+faces[i].width*0.5-cenO.x<0&&theta<0)theta = 180+ theta;
	 else if(faces[i].x+faces[i].width*0.5-cenO.x<0&&theta>0)theta = 180+ theta;
	  double radius = sqrt((double)((faces[i].y+ faces[i].height*0.5-cenO.y)*(faces[i].y+ faces[i].height*0.5-cenO.y)+(faces[i].x+faces[i].width*0.5-cenO.x)*(faces[i].x+faces[i].width*0.5-cenO.x)));
	
     ellipse( frame, center, Size( faces[i].width*0.5, faces[i].height*0.5), 0, 0, 360, Scalar( 255, 0, 255 ), 2, 8, 0 );

	 //cout<<faces[i].x + faces[i].width*0.5<<"  "<<faces[i].y + faces[i].height*0.5<<endl;
	 theta/=180.0;
	 theta*=PI;
	 
	//  cout<<theta<<endl;
      Mat faceROI = frame_gray( faces[i] );
      std::vector<Rect> eyes;

      //-- In each face, detect eyes
	  
     eyes_cascade.detectMultiScale( faceROI, eyes, 1.1, 2, 0 |CV_HAAR_SCALE_IMAGE, Size(30,30) );

      for( int j = 0; j < eyes.size(); j++ )
       {
         Point center( faces[i].x + eyes[j].x + eyes[j].width*0.5, faces[i].y + eyes[j].y + eyes[j].height*0.5 );
         int radius = cvRound( (eyes[j].width + eyes[j].height)*0.25 );
         circle( frame, center, radius, Scalar( 255, 0, 0 ), 3, 8, 0 );
		 //cout<<"track eye "<< j<<endl;
		 //cout<<faces[i].x + eyes[j].x + eyes[j].width*0.5<<"   "<<faces[i].y + eyes[j].y + eyes[j].height*0.5<<endl;
       }
	   if(radius>50){
		  mx = AU3_MouseGetPosX();
		   my = AU3_MouseGetPosY();
		  int mr = radius - 50;
		 AU3_MouseMove(mx+mr*cos(theta),my-mr*sin(theta),0);
		  line(frame,cenO,center,Scalar( 255, 0, 0),1,8,0);
	  }
	   else { 
		  if(eyes.size()==0){
			  cout<<timeCounter<<endl;
			if(timeCounter<30)timeCounter++;
			else {
				cout<<timeCounter<<endl;
			   cout<<"Change"<<endl;
			   AU3_ProcessClose(L"osk-l.exe");
			   AU3_ProcessClose(L"osk-m.exe");
			   AU3_ProcessClose(L"osk-s.exe");
			   kbCount%=3;
			   char buff[1000];
			   sprintf(buff,"start %s",wstrlist[kbCount++]);
			   cout<<buff<<endl;
			   system(buff);
				timeCounter=0;
			}
		  }else timeCounter = 0;
		  
		  line(frame,cenO,center,Scalar( 255, 255, 0),1,8,0);
	  }
   }
   //-- Show what you got
 
  imshow( window_name, frame );
}