	-==NOTES FOR BLACK LOTUS SLIDER V1.0 ==-


TABLE OF CONTENTS
 0. Before Anything Else
 1. Introduction
 2. Commonly Asked Questions
 3. Troubleshooting / Hints
 4. Contact Us
 5. Legal Notice



0. BEFORE ANYTHING ELSE

Before you do anything else, run Reset.exe located in the current folder.  This will reset the initilization file so that the program will know that folder to start out in.



1. INTRODUCTION

Black Lotus Slider is a program written to view all the picture images in a specified folder.  You point the program towards a folder, specify the filespec or wildcard to be viewed, and let the slide show start.  There are quite a few options - a randomize feature, time delay in seconds that can be toggled on or off, optional viewing of Prev / Next buttons in view mode just to start.  You also have the option to change the full-sized picture window to any corner or center at half the size.  This becomes an incredibly usefull and fun utility if you happen to own a digital camera and want to view your pictures in a fun, easy-to-use format.



2. COMMONLY ASKED QUESTIONS

Q.  What file types are supported?
A.  Black Lotus Slider will correctly reconize .BMP, .JPG, .GIF, .ICO, .WMF and .EMF file formats with or without the proper extension.

Q.  How do I quit the program?
A.  Select QUIT from the Options menu.

Q.  How do I get to the Options menu?
A.  Just click on the slideshow image.

Q.  I keep getting errors.  How can that be fixed?
A.  One slight limitation to this program is that it needs to be pointed to a folder that contains image files.  An error is encountered if the program tries to work with an empty folder or load a file that is not one of the supported images file types.  Take a look at Troubleshooting / Hints section for more info.



3. TROUBLESHOOTING / HINTS

The program works with a file called BLSINI.DAT when it saves the settings in the options menu.  Sometimes the options can be saved to this file when they are incorrect.  Examples of incorrect option setups would be: choosing a filespec that doesn't exist in the current folder or included non-image files, or choosing a folder that doesn't contain no or non-image files within the current filespec. 
HINT : KEEP THE IMAGES YOU WANT TO VIEW IN A SEPERATE FOLDER THAT CONTAINS NO NON-IMAGES.

If your BLSINI.DAT file becomes corrupt while still in the program, cliking on Reset Options will return both the program and the datafile to the default settings.  The default viewing folder is the folder the program is running from, and the default filespec is (*.JPG).

If your BLSINI.DAT file becomes corrupt and the program won't fully load you will have to run Reset.exe.  This will also reset the data file to it's correct settings.

In case you want to change the settings manually you can open the file with any text editor.  There are seven lines of text containing seven saved settings. Look below to see what lines pertain to what data items.

LINE 1: Full path of viewing folder contained within
	quotation marks.
	Ex.: "C:\JONS\2\"

LINE 2: Filespec/wildcard extension telling what files
	within folder to be included.  Contained within
	quotation marks.
	Ex.: "*.JPG"

LINE 3: Number of seconds for delay time.
	Ex.: 3

LINE 4: Randomize enabled?  Valid responses are #TRUE# or
	#FALSE#.
	Ex.: #TRUE#

LINE 5: Disable timer?  Valid responses are #TRUE# or
	#FALSE#.
	Ex.: #FALSE#

LINE 6: View control buttons?  Valid responses are #TRUE# or
	#FALSE#.
	Ex.: #FALSE#

LINE 7: Screen mode. Integer from 1 to 6.  6 is fullscreen.
	1-5 are half scale at the following locations
	respectivaly: top-left, top-right, bottom-left,
	bottom-right, center.

HINT : ALL YOU HAVE TO DO TO KEEP THE OPTIONS DATA FILE CORRECT IS TO BE CAREFUL WHEN MAKING CHANGES TO FILELIST INFO IN OPTIONS.  DON'T SET ANYTHING TO AN OPTION THAT DOESN'T MAKE SENSE.



4. CONTACT US

Want some more cool utilities and games, all for free? You can visit Black Lotus Software on the net at http://www.angelfire.com/wa/blacklotus, or you can leave an email at blotusmail@aol.com.  We would appreciate your input.



5. LEAGAL NOTICE

THIS SOFTWARE AND ALL INCLUDED FILES ARE COPYRIGHT 1999 BY BLACK LOTUS SOFTWARE.  ALL RIGHTS ARE RESERVED.  YOU MAY DISTRIBUTE THIS SOFTWARE FREELY IF IT HAS NOT BEEN MODIFIED.  MODIFICATIONS ARE NOT PERMITTED WITHOUT DIRECT PERMISSION FROM BLACK LOTUS SOFTWARE.

PROGRAM WRITTEN AND COMPILED IN MICROSOFT VISUAL BASIC 5.0.  ALL WORK WAS DONE BY JON HYLAND, PRESIDENT OF BLACK LOTUS SOFTWARE AND PRODUCTIONS