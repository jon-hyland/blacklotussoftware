
FileBlocps.dll: dlldata.obj FileBloc_p.obj FileBloc_i.obj
	link /dll /out:FileBlocps.dll /def:FileBlocps.def /entry:DllMain dlldata.obj FileBloc_p.obj FileBloc_i.obj \
		kernel32.lib rpcndr.lib rpcns4.lib rpcrt4.lib oleaut32.lib uuid.lib \

.c.obj:
	cl /c /Ox /DWIN32 /D_WIN32_WINNT=0x0400 /DREGISTER_PROXY_DLL \
		$<

clean:
	@del FileBlocps.dll
	@del FileBlocps.lib
	@del FileBlocps.exp
	@del dlldata.obj
	@del FileBloc_p.obj
	@del FileBloc_i.obj
