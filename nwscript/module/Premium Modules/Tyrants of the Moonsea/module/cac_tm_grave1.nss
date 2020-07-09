// secrets: the player has dug up a grave, so spawn a corpse

#include "hf_in_plot"
#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_fplaguecrpse", GetLocation(OBJECT_SELF));
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    AdjustPlayerAlignment(oPC, ALIGNMENT_CHAOTIC, 2);
}
