var
 TFile : text;
 Cha   : char;

begin
 assign(TFile, 'READMSG.PAS');
 reset(TFile);
 while not Eof(TFile) do
  read(TFile, Cha);
 close(TFile);
end.

