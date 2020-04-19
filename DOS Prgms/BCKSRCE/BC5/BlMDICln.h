//----------------------------------------------------------------------------
//  Project Bla
//  PDE EXTREME
//  Copyright © 1997. All Rights Reserved.
//
//  SUBSYSTEM:    Bla Application
//  FILE:         blmdicln.h
//  AUTHOR:       DaProgramr
//
//  OVERVIEW
//  ~~~~~~~~
//  Class definition for TBlaMDIClient (TMDIClient).
//
//----------------------------------------------------------------------------
#if !defined(blmdicln_h)              // Sentry, use file only if it's not already included.
#define blmdicln_h

#include "blaapp.rh"            // Definition of all resources.


//{{TMDIClient = TBlaMDIClient}}
class TBlaMDIClient : public TMDIClient {
  public:
    int      ChildCount;                 // Number of child window created.

    TBlaMDIClient(TModule* module = 0);
    virtual ~TBlaMDIClient();

    void OpenFile(const char* fileName = 0);

//{{TBlaMDIClientVIRTUAL_BEGIN}}
  protected:
    virtual void SetupWindow();
//{{TBlaMDIClientVIRTUAL_END}}

//{{TBlaMDIClientRSP_TBL_BEGIN}}
  protected:
    void CmFilePrint();
    void CmFilePrintSetup();
    void CmFilePrintPreview();
    void CmPrintEnable(TCommandEnabler& tce);
    void EvDropFiles(TDropInfo);
//{{TBlaMDIClientRSP_TBL_END}}
DECLARE_RESPONSE_TABLE(TBlaMDIClient);
};    //{{TBlaMDIClient}}


#endif  // blmdicln_h sentry.
