
FileBlockps.dll: dlldata.obj FileBlock_p.obj FileBlock_i.obj
	link /dll /out:FileBlockps.dll /def:FileBlockps.def /entry:DllMain dlldata.obj FileBlock_p.obj FileBlock_i.obj \
		kernel32.lib rpcndr.lib rpcns4.lib rpcrt4.lib oleaut32.lib uuid.lib \

.c.obj:
	cl /c /Ox /DWIN32 /D_WIN32_WINNT=0x0400 /DREGISTER_PROXY_DLL \
		$<

clean:
	@del FileBlockps.dll
	@del FileBlockps.lib
	@del FileBlockps.exp
	@del dlldata.obj
	@del FileBlock_p.obj
	@del FileBlock_i.obj
