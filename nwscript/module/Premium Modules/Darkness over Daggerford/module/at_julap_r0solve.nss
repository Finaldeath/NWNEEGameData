// player has been given julap's first riddle

#include "hf_in_plot"

void main()
{
    object oArea = GetArea(GetPCSpeaker());
    SetLocalInt(oArea, "nJulapRiddleNumber", 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 3);
}
