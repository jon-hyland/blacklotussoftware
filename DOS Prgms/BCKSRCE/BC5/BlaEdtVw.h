//----------------------------------------------------------------------------
//  Project Bla
//  PDE EXTREME
//  Copyright © 1997. All Rights Reserved.
//
//  SUBSYSTEM:    Bla Application
//  FILE:         blaedtvw.h
//  AUTHOR:       DaProgramr
//
//  OVERVIEW
//  ~~~~~~~~
//  Class definition for TBlaEditView (TEditView).
//
//----------------------------------------------------------------------------
#if !defined(blaedtvw_h)              // Sentry, use file only if it's not already included.
#define blaedtvw_h

#include <owl/editview.h>

#include "blaapp.rh"          // Definition of all resources.


//{{TEditView = TBlaEditView}}
class TBlaEditView : public TEditView {
  public:
    TBlaEditView(TDocument& doc, TWindow* parent = 0);
    virtual ~TBlaEditView();

//{{TBlaEditViewVIRTUAL_BEGIN}}
  public:
    virtual void Paint(TDC& dc, bool erase, TRect& rect);
//{{TBlaEditViewVIRTUAL_END}}
//{{TBlaEditViewRSP_TBL_BEGIN}}
  protected:
    void EvGetMinMaxInfo(MINMAXINFO far& minmaxinfo);
//{{TBlaEditViewRSP_TBL_END}}
DECLARE_RESPONSE_TABLE(TBlaEditView);
};    //{{TBlaEditView}}


#endif  // blaedtvw_h sentry.
