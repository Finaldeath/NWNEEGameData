//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_eremuth1
//:: DATE: March 4, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Eremuth conversation
//:: Sets dialog level to "spoken" to.
//:: Also deactivates his trigger
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(GetTag(OBJECT_SELF), 1);

    SetLocalInt(oPC, "eremuthtrigger", 2);
}
