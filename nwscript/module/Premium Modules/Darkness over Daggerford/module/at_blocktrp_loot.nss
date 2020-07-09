#include "hf_in_plot"

// give the player a precious gem
void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    CreateItemOnObject(GetLocalString(OBJECT_SELF, "sBlockTrapLoot"), oPC, 1);
}
