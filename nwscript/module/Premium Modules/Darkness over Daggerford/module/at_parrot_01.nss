// the player steals the parrot from poor hester

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    PlotLevelSet("ks_hester", 3);
    CreateItemOnObject("a2_parrot", oPC, 1);
    DestroyObject(OBJECT_SELF);
}
