//----------------------------------------------------------------------------
//  Project Bla
//  PDE EXTREME
//  Copyright © 1997. All Rights Reserved.
//
//  SUBSYSTEM:    Bla Application
//  FILE:         blmdichl.cpp
//  AUTHOR:       DaProgramr
//
//  OVERVIEW
//  ~~~~~~~~
//  Source file for implementation of TBlaMDIChild (TMDIChild).
//
//----------------------------------------------------------------------------

#include <owl/pch.h>

#include "blaapp.h"
#include "blmdichl.h"


//{{TBlaMDIChild Implementation}}


//--------------------------------------------------------
// TBlaMDIChild
// ~~~~~~~~~~
// Construction/Destruction handling.
//
TBlaMDIChild::TBlaMDIChild(TMDIClient& parent, const char far* title, TWindow* clientWnd, bool shrinkToClient, TModule* module)
:
  TMDIChild(parent, title, clientWnd, shrinkToClient, module)
{
  // INSERT>> Your constructor code here.

}


TBlaMDIChild::~TBlaMDIChild()
{
  Destroy();

  // INSERT>> Your destructor code here.

}
