//----------------------------------------------------------------------------
//  Project Bla
//  PDE EXTREME
//  Copyright © 1997. All Rights Reserved.
//
//  SUBSYSTEM:    Bla Application
//  FILE:         blmdichl.h
//  AUTHOR:       DaProgramr
//
//  OVERVIEW
//  ~~~~~~~~
//  Class definition for TBlaMDIChild (TMDIChild).
//
//----------------------------------------------------------------------------
#if !defined(blmdichl_h)              // Sentry, use file only if it's not already included.
#define blmdichl_h

#include "blaapp.rh"            // Definition of all resources.


//{{TMDIChild = TBlaMDIChild}}
class TBlaMDIChild : public TMDIChild {
  public:
    TBlaMDIChild(TMDIClient& parent, const char far* title, TWindow* clientWnd, bool shrinkToClient = false, TModule* module = 0);
    virtual ~TBlaMDIChild();
};    //{{TBlaMDIChild}}


#endif  // blmdichl_h sentry.
