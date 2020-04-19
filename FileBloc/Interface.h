// Interface.h : Declaration of the CInterface

#ifndef __INTERFACE_H_
#define __INTERFACE_H_

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CInterface
class ATL_NO_VTABLE CInterface : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CInterface, &CLSID_Interface>,
	public IDispatchImpl<IInterface, &IID_IInterface, &LIBID_FILEBLOCLib>
{
public:
	CInterface()
	{
	}

DECLARE_REGISTRY_RESOURCEID(IDR_INTERFACE)

DECLARE_PROTECT_FINAL_CONSTRUCT()

BEGIN_COM_MAP(CInterface)
	COM_INTERFACE_ENTRY(IInterface)
	COM_INTERFACE_ENTRY(IDispatch)
END_COM_MAP()

// IInterface
public:
};

#endif //__INTERFACE_H_
