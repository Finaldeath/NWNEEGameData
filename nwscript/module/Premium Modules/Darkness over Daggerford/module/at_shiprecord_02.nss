// this just allows the player to take a copy of the shipping records
// .. I'm not sure that this is needed, but it's kind of fun

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("a2_shiprecord", oPC);
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
}
