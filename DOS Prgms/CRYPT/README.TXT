Sound Blaster AWE64/AWE64 Gold Readme File
==========================================

This file contains additional information to supplement the manual.
Please read all the sections before you proceed with the installation.

This file contains the following sections:

    1.  Installation
    2.  Uninstallation
    3.  DOS Environment settings
    4.  DOS Audio Driver Support under Windows 95 DOS Box
    5.  Using CREATIVE IDE CD-ROM drive in MS-DOS Mode
    6.  BLASTER settings under MS-DOS Mode
    7.  DRAM Issues
    8.  Playing MIDI files in GS Mode
    9.  AWE Control Panel WaveFx
    10. Full-Duplex Constraints
    11. SoundFont banks
    12. Mapping instruments to multiple MIDI devices
    13. Online Documentation
    14. Acknowledgments


1.  INSTALLATION

    The full installation option requires about 21 MBytes of hard disk
    space for program files and an additional 2 MBytes for working space. 
    You might need more if your drive is in compressed form.


2.  UNINSTALLATION

    Before uninstalling the software package, ensure that all Sound
    Blaster AWE64/AWE64 Gold applications are closed. Any Sound Blaster
    AWE64/AWE64 Gold application that is running while uninstallation
    is in progress will not be deleted. Also, files that are added
    to the Sound Blaster AWE64/AWE64 Gold directory after the initial
    software installation will not be deleted by the uninstallation
    process. You will have to manually delete these files after the
    uninstallation process is completed.

    Some of the Sound Blaster AWE64/AWE64 Gold files in the Windows
    directory are shared by other applications. The uninstallation
    program will prompt you when it tries to delete these files. You
    should choose not to delete the files unless you are very sure
    that they are no longer used by Windows.


3.  DOS ENVIRONMENT SETTINGS

    Some of the existing DOS programs require the presence of MIDI and
    SOUND environments in order for them to work. The Setup program will
    add the SET MIDI and SET SOUND lines at the beginning of
    the AUTOEXEC.BAT file.


4.  DOS AUDIO DRIVER SUPPORT UNDER WINDOWS 95 DOS BOX

    Some of the DOS applications are developed with Creative's Sound
    Blaster Developer Kit. These applications require the low-level
    DOS device drivers to be loaded. To load these drivers, you need
    to add the following lines to the CONFIG.SYS file:

    DEVICE=C:\<dir>\DRV\CTSB16.SYS /UNIT=0 /BLASTER=A:220 I:5 D:1 H:5 /WIN95
    DEVICE=C:\<dir>\DRV\CTMMSYS.SYS

    Remarks:

    a. <dir> is the sound directory where the audio software is located.

    b. The /BLASTER parameter specifies the Sound Blaster base I/O port
       address (A), interrupt request line (I), low 8-bit DMA channel
       (D) and high 16-bit DMA channel (H).

    c. The settings in the /BLASTER parameter must tally with the actual
       settings allocated by Windows 95. To find out the actual settings,
       go into Windows 95 DOS box, and type SET and press <Enter> at the
       DOS prompt. You will see one of the lines displayed as:

		BLASTER=A220 I5 D1 H5 P330 T6

       The values after A, I, D and H are the actual settings to be
       used for the /BLASTER parameter.

    To help you set up the DOS audio drivers, we have prepared a text
    file CONFIG.TXT in the sound directory. This text file contains
    the above two lines to specify the DOS audio drivers. The sound
    directory name in the text file will be updated by the installation
    program. All you need to do is update the /BLASTER parameter,
    then use a text editor to copy the two lines from the CONFIG.TXT file
    and paste them into the CONFIG.SYS file.


5.  USING CREATIVE IDE CD-ROM DRIVE UNDER MS-DOS MODE

    When you open an MS-DOS Mode session, the system will close all other
    active programs. You can return to Windows 95 by typing EXIT.
    There are two ways to start an MS-DOS Mode session, either

    - shut down the system using the Start menu and choose the
      "Restart the computer in MS-DOS Mode" option, or

    - start a MS-DOS box and change the properties of your MS-DOS session
      by checking the MS-DOS Mode box under the Advanced Program Settings.
      You can specify to use either the current MS-DOS configuration,
      or a new MS-DOS configuration.

    If you connect a Creative IDE CD-ROM drive to the IDE interface
    that comes with your card, you need to do the following steps
    to make your CD-ROM drive work in MS-DOS Mode:

    5.1 Shutdown and restart the computer in MS-DOS Mode

        You need to add the following lines to the DOSSTART.BAT file
        in the Windows directory:

	 <C:\dir>\CTLOAD <C:\dir>\DRV\SBIDE.SYS /D:MSCD001 /V /P:1E8,11,3EE
	 <C:\win95dir>\COMMAND\MSCDEX /D:MSCD001 /V /M:8

	 NOTES:

	 a. DOSSTART.BAT is a batch file in the Windows directory.
            It is executed every time you start an MS-DOS Mode session.

	 b. <C:\dir> is the sound directory where the audio software
	    is located.

	 c. <C:\win95dir> is the Windows 95 directory.

       To help you set up the DOS audio drivers, we have prepared
       a text file DOSSTART.TXT in the sound directory. It contains
       the above lines to specify the DOS CD-ROM drivers.  The sound
       directory name in the text file will be updated by the installation program.
       You don't need to change any of the parameters.

    5.2 Changing MS-DOS MODE session properties and selecting MS-DOS Mode
        using current configuration

        You need to do the same steps as above.

    5.3 Changing MS-DOS MODE session properties and selecting MS-DOS Mode
        using current configuration

        You need to add the following lines to the new AUTOEXEC.BAT :

         <C:\win95dir>\CTCM
         <C:\dir>\CTLOAD <C:\dir>\DRV\SBIDE.SYS /D:MSCD001 /V /P:1E8,11,3EE
         <C:\win95dir>\COMMAND\MSCDEX /D:MSCD001 /V /M:8

         NOTES:

         a. <C:\dir> is the sound directory where the audio software
            is located.

         b. <C:\win95dir> is the Windows 95 directory.

         c. Make sure that the settings in the /P parameter tally with the
            actual settings allocated by Windows 95.


6.  BLASTER SETTINGS UNDER MS-DOS Mode

    Whenever you change your audio hardware configuration using Plug and Play
    configuration utility, the BLASTER environment settings under MS-DOS Mode
    will only be valid after you have rebooted the system.

    However, if you proceed to MS-DOS Mode without rebooting, you need to run
    CTCM.EXE (found in your Windows directory).  This program makes the
    BLASTER environment setting tally with the actual hardware settings.


7.  DRAM ISSUES

    a) If your audio card does not have the DRAM Upgrade option, please
       ignore all references to it in your Getting Started and online
       documentation.

    b) If your audio card has no DRAM (either built-in, installed in SIMM
       sockets, or installed using DRAM daughterboard), ignore the sections
       in your Getting Started and online documentation that refer to
       General Standard (GS), MT-32, and SoundFonts.


8.  PLAYING MIDI FILES IN GS MODE

    For audio cards equiped with 512KB of RAM memory or more, you can
    configure it using the AWE Control Panel to play the MIDI file
    SFX.MID in GS Mode for the best effects.


9.  AWE CONTROL PANEL WAVEFX

    To download a wave sample as a WaveFx sample using AWE Control Panel, 
    your card must have DRAM built-in, installed in SIMM sockets, or installed 
    using DRAM daughterboard. AWE Control Panel can support samples in all
    ADPCM wave formats.


10. FULL-DUPLEX CONSTRAINTS

    Your audio card supports full-duplex recording and playback. However, to 
    make full use of this feature, please make sure you observe the following 
    constraints:

    a. Start only one session of simultaneous playback and recording.  
    b. Use the same sampling rate for both operations.
    c. Preferably play back and record audio files which are in uncompressed
       wave format, that is, Pulse Code Modulation (PCM).
    d. Reduce the sampling rate for both operations if your audio playback or
       recording session is too slow.

    NOTE: The Full-Duplex and DirectSound capabilities are mutually
          exclusive. If you activate the full-duplex feature, the
          DirectSound capability cannot be enabled. And vice versa.


11. SOUNDFONT BANKS

    There are three SoundFont banks shipped with AWE64/AWE64 Gold . The
    following is a brief description of each file:

    GM35REVC.SF2 - Three and a half MB bank General MIDI bank.
    4GMGSMT.SF2  - Four MB General MIDI bank with GS variation tones.
    2GMGSMT.SF2  - Two MB General MIDI bank with GS variation tones.

    If you are playing any MIDI files that uses GS variation tones, you
    will have to load either the 2 or 4 MB banks as the synthesizer bank.


12. MAPPING INSTRUMENTS TO MULTIPLE MIDI DEVICES

    Instruments to be played from any channels in a MIDI file can be
    mapped to any available MIDI output devices on the Sound Blaster
    AWE64/AWE64 Gold card. Sound Blaster AWE64/AWE64 Gold comes with
    two components that help to make this possible. They are the
    Creative MIDI Instrument Mapper and Creative Virtual MIDI Driver.
    The mapper and driver, when used together, allow you to define
    mappings of how you would like the instrument to sound like.

    The mapping causes all note related MIDI events to be routed
    according to the configured mappings. You can map instruments in
    two different ways, by using the Creative MIDI Instrument Mapper
    or sending MIDI System Exclusive events.

    If you wish to experiment multiple MIDI device playback on any
    existing MIDI files, you may choose to use the Creative MIDI
    Instrument Mapper. Refer to the online documentation on how to
    configure mapping.

    On the other hand, if you are creating or editing a MIDI file from
    a MIDI sequencer, you can choose the second option which is to send
    System Exclusive events to the Virtual MIDI driver. The following
    events may be entered at the beginning of the MIDI tracks using
    your favourite sequencer. However, MIDI files with these System
    Exclusive events encoded must be sent to the Creative Virtual
    MIDI driver for the mappings to take effect.

    a. To direct (lock) all MIDI events to a particular MIDI device, use

       F0 00 20 21 01 00 xx F7

       where xx stands for one of the following:

       08 - AWE
       0C - WaveSynth
       10 - FM
       14 - MIDI Out

    b. To undo (unlock) what has been done in (1), use

       F0 00 20 21 01 01 F7

    c. To direct (lock) all MIDI events in a particular channel to
       another device, use

       F0 00 20 21 01 02 yy xx F7

       where yy is the desired MIDI channel and xx stands for one of:

       08 - AWE
       0C - WaveSynth
       10 - FM
       14 - MIDI Out

    d. To undo (unlock) the channel mappings done in (3), use

       F0 00 20 21 01 03 yy F7

       where  yy is the MIDI channel number.

    e. To map individual instruments to a desired MIDI device, use

       F0 00 20 21 01 04 00 smb slb sp xx dmb dlb dp F7

       where,

       smb - MIDI bank to be mapped from. Contains MSB part of the
             bank num.
       slb - MIDI bank to be mapped from. Contains LSB part of the
             bank num.
       sp  - MIDI patch to be mapped from
       xx  - Destination MIDI device (see above)
       dmb - MIDI bank to be mapped to the Destination MIDI device.
             Contains MSB part of the bank num.
       dlb - MIDI bank to be mapped to the Destination MIDI device.
             Contains LSB part of the bank num.
       dp  - MIDI patch to be mapped to the Destination MIDI device

      smb and slb forms bank numbers that appears in your MIDI files.
      Most MIDI files use only bank 0, i.e. smb and slb sets to 0. dmb
      and dlb forms bank numbers that will be mapped to the destination
      MIDI device. For example, to map Bank 5 Patch 3 in a MIDI file to
      use Bank 0 Patch 3 of AWE device, the System Exclusive message
      will be

       F0 00 20 21 01 04 00 00 05 03 08 00 00 03 F7

    f. To remove any mappings done in (5), use

       F0 00 20 21 01 05 00 sb sb sp F7


13. ONLINE DOCUMENTATION

    To help you get information on the applications in this package easily,
    we have compiled a set of online documentation which can be accessed from 
    your audio card's program group.  Just click the START button on your 
    Windows 95 taskbar. Select "Programs", followed by "Sound Blaster AWE64"
    or "Sound Blaster AWE64 Gold" and then "User's Guide".


14. ACKNOWLEDGMENTS

    MS-DOS, Windows, and the Windows logo are trademarks of Microsoft
    Corporation. All other products are trademarks or registered trademarks
    of their respective owners.


IMPORTANT NOTE in USING Creative MIDI Instrument Mapper under Win95 :

    The default setting for Single Instrument (in the MIDI tabbed page of
    the Multimedia Properties dialog box) is Creative MIDI Instrument Mapper.
    With this setting, you can use the MIDI Instrument Mapper application to
    customize instrument mappings.

    However, if you need to customize MIDI channels using Custom Configuration,
    we recommend that you do not assign Creative MIDI Instrument Mapper to any
    of the MIDI channels.


 Frequently Asked Questions for WaveSynth/WaveSynth-WG Upgrade
 =============================================================

 This file contains answers to frequently asked questions (FAQs) 
 about Creative WaveSynth/WaveSynth-WG Upgrade. If you have a 
 question, read this file first before calling Creative 
 Technical Support since you will most probably find the answer 
 here.


 Q1.   Cannot record WaveSynth MIDI playback.

 A1.   This is correct.  WaveSynth MIDI playback is really wave 
       playback. When you play a MIDI file through the WaveSynth 
       MIDI device, WaveSynth synthesizes the MIDI data into 
       wave data and plays it through the sound card. Unlike 
       sources such as CD, Line-In, and microphone, wave is not
       a recording source. Thus, you cannot record the WaveSynth 
       MIDI playback.


 Q2.   After installing DirectX or DirectX games, I cannot 
       play MIDI files through WaveSynth(/WG).

 A2.   When DirectX or DirectX games are installed, they may  
       overwrite the SB16 audio drivers with an older version 
       that does not support WaveSynth(/WG). Run UPPDRV95.EXE
       found in this installation package to reinstall the 
       drivers. Reboot your system for the changes to take 
       effect.


 Q3.   How do I know whether Creative WaveSynth/WG has been correctly
       installed into Windows?

 A3.   Well, there are a few ways to confirm that:
       a.Go to Control Panel, double click on the "Mulitmedia" icon.
       b.Go to "MIDI" tab.
       c.If Creative WaveSynth/WG is installed, you should see the
       following MIDI devices:
               .WaveSynth/WG
               .Creative Instrument Mapper
      (Ensure "Creative INstrument Mapper" is selected) 

      To further confirm, ensure that the following files are installed
      into the /WINDOWS/SYSTEM directory:
               .VWAVSYN.386
               .WAVSYNWG.DRV
               .CTVMD.DRV
               .WAVSYN.PCM
               .CIFMAN.DLL
               .CIFMAN.CRL

            **********  E N D   O F   R E A D M E  **********
