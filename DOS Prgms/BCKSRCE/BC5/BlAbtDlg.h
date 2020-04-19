//----------------------------------------------------------------------------
//  Project Bla
//  PDE EXTREME
//  Copyright © 1997. All Rights Reserved.
//
//  SUBSYSTEM:    Bla Application
//  FILE:         blabtdlg.h
//  AUTHOR:       DaProgramr
//
//  OVERVIEW
//  ~~~~~~~~
//  Class definition for TBlaAboutDlg (TDialog).
//
//----------------------------------------------------------------------------
#if !defined(blabtdlg_h)              // Sentry, use file only if it's not already included.
#define blabtdlg_h

#include <owl/static.h>

#include "blaapp.rh"                  // Definition of all resources.


//{{TDialog = TBlaAboutDlg}}
class TBlaAboutDlg : public TDialog {
  public:
    TBlaAboutDlg(TWindow* parent, TResId resId = IDD_ABOUT, TModule* module = 0);
    virtual ~TBlaAboutDlg();

//{{TBlaAboutDlgVIRTUAL_BEGIN}}
  public:
    void SetupWindow();
//{{TBlaAboutDlgVIRTUAL_END}}
};    //{{TBlaAboutDlg}}


// Reading the VERSIONINFO resource.
//
class TProjectRCVersion {
  public:
    TProjectRCVersion(TModule* module);
    virtual ~TProjectRCVersion();

    bool GetProductName(LPSTR& prodName);
    bool GetProductVersion(LPSTR& prodVersion);
    bool GetCopyright(LPSTR& copyright);
    bool GetDebug(LPSTR& debug);

  protected:
    uint8 far*  TransBlock;
    void far*   FVData;

  private:
    // Don't allow this object to be copied.
    //
    TProjectRCVersion(const TProjectRCVersion&);
    TProjectRCVersion& operator = (const TProjectRCVersion&);
};


#endif  // blabtdlg_h sentry.
