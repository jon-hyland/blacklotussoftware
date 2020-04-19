//----------------------------------------------------------------------------
//  Project Bla
//  PDE EXTREME
//  Copyright © 1997. All Rights Reserved.
//
//  SUBSYSTEM:    Bla Application
//  FILE:         blaapp.h
//  AUTHOR:       DaProgramr
//
//  OVERVIEW
//  ~~~~~~~~
//  Class definition for TBlaApp (TApplication).
//
//----------------------------------------------------------------------------
#if !defined(blaapp_h)              // Sentry, use file only if it's not already included.
#define blaapp_h

#include <owl/controlb.h>
#include <owl/docking.h>
#include <owl/mailer.h>
#include <owl/printer.h>
#include <owl/rcntfile.h>

#include <classlib/bags.h>

#include "blmdicln.h"

#include "blaapp.rh"            // Definition of all resources.


//{{TApplication = TBlaApp}}
class TBlaApp : public TApplication, public TRecentFiles {
  private:
    void SetupSpeedBar(TDecoratedMDIFrame* frame);
    void AddFiles(TFileDropletList& files);
    void ProcessCmdLine(char * CmdLine);
    void RegisterInfo();
    void UnRegisterInfo();

  public:
    TBlaApp();
    virtual ~TBlaApp();

    void CreateGadgets(TDockableControlBar* cb, bool server = false);
    THarbor*        ApxHarbor;

    TBlaMDIClient* MdiClient;

    // Public data members used by the print menu commands and Paint routine in MDIChild.
    //
    TPrinter*       Printer;                           // Printer support.
    int             Printing;                          // Printing in progress.

    TMailer*        ApxMail;

//{{TBlaAppVIRTUAL_BEGIN}}
  public:
    virtual void InitMainWindow();
    virtual void InitInstance();
//{{TBlaAppVIRTUAL_END}}

//{{TBlaAppRSP_TBL_BEGIN}}
  protected:
    void EvNewView(TView& view);
    void EvCloseView(TView& view);
    void CeFileSend(TCommandEnabler& ce);
    void CmFileSend();
    void CmHelpAbout();
    void EvDropFiles(TDropInfo drop);
    void EvWinIniChange(char far* section);
    void EvOwlDocument(TDocument& doc);
    int32 CmFileSelected(uint wp, int32 lp);
//{{TBlaAppRSP_TBL_END}}
DECLARE_RESPONSE_TABLE(TBlaApp);
};    //{{TBlaApp}}


#endif  // blaapp_h sentry.
