program TestLoadLevel;

type
 Level_Obj_Type = array[1..80, 1..20] of boolean;
 Level_Obj_Type = array[1..80, 20] of
  (Wall, Tree, Door, Rock, Water,