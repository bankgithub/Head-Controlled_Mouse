#Head-Controlled Mouse System for Quadriplegic
A mouse controlled software based on eye detection, face detection, and speech recognition. 

![](/git_pic/screenshot.gif)

#Installation
- Setup
  - run setup.exe
  - restart computer
- Portable
  - run \control\bin\NSC.exe
  
#How to use
- control mouse pointer by moving head around
- say "left" for left click
- say "right" for right click
- say "up" for zooming
- say "down" for on screen keyboard
- say "enter" to hit enter
- say "stop" to terminate foreground program
- press ESC to terminate control program
- say "option" to launch hotpad and setting
- move user head out of camera sight for 7 seconds to turn of monitor

#Techniques
The detection techniques are based on [Viola Jones](http://docs.opencv.org/master/d7/d8b/tutorial_py_face_detection.html#gsc.tab=0) and were implemented in C++. Speech recognition was imported from [HTK Speech Recognition Toolkit](http://htk.eng.cam.ac.uk/).

#Assistive Features
- On Screen Keyboard
  - three size with Thai,English language support
![](/git_pic/osk.png)

- Zoom
  - three size with 2 modes : dynamic, static
![](/git_pic/zoom.gif)

- Mouse Control
  - joystick : pointer speed is based on distance from the center of camera
  - velocity : pointer speed is based on user's velocity
  - mapping  : pointer moves directly to the coordinate related between screen and camera
  - reading  : joystick mode with auto scroll
  
- Setting
  - zoom size and mode
  - mouse speed and mode
  - keyboard position and size
  - turn of specific speech recognition features
  - duration until monitor close
  
- Hotpad
  - keystroke and mouse click recorder  
![](/git_pic/hotpad.gif)
	
#Training Games
- Lyreth
  - sentence structure practice game
- Gaze Path
  - maze game
  
![](/git_pic/game.png)

#File Structure
- control
  - bin
    - NSC.exe     [main]
	- osk-*.exe   [on screen keyboard]
	  - kb_layout [on screen keyboard layout]
	- option.exe  [hotpad]
	  - command   [hotpad task coordinates]
	- setting.exe [adjust assistive tools' parameters]
	- monitor.exe [turn off monitor]
	- close.exe   [terminate software]
	- zoom.exe    [magnifier]
  - grammar       [HTK grammar set]
- source		  [source code, icon, and layout]
- training
  - lyreth		  [sentence structure practice game]
  - gazepath      [maze game]
- setup.exe       [install on C:\]
- startup.reg     [add software to starup program]
 