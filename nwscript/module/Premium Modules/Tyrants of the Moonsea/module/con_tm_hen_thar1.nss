//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_thar1
//:: DATE: January 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Checks whether the PC is currently in Thar
//::////////////////////////////////////////////////////

#include "hf_in_henchman"
#include "hf_in_plot"

const string AREA_TAG = "TharScar";

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (HenchmanIsMine(oHench, oPC) && (GetTag(GetArea(oPC)) == AREA_TAG));
}
