uses crt, fsmouse;

var Mouse : TMouse;
    a : byte; X : INTEGER;
begin
  clrscr;
  Mouse.Init;
  writeln('Number of buttons : ', Mouse.GetNumberOfButtons);
  Mouse.ShowMouse;
  x := 0;
  repeat
    a := Mouse.ButtonPressed;
    x := x + 1;
    writeln(x);
    if a <> 0 then
      begin
        Mouse.HideMouse;
        case a of
          1 : writeln('Left   ', Mouse.GetY, ',', Mouse.GetX);
          2 : writeln('Right  ', Mouse.GetY, ',', Mouse.GetX);
          3 : writeln('Middle ', Mouse.GetY, ',', Mouse.GetX);
        end;
        Mouse.ShowMouse;
      end;
  until keypressed;
  Mouse.HideMouse;
end.

