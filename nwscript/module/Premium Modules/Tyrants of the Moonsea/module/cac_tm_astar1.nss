//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_astar1
//:: DATE: March 4, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Astar conversation
//:: - Sets dialog level to "spoken" to.
//:: - Deactivates his trigger.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet(GetTag(OBJECT_SELF), 1);

    SetLocalInt(oPC, "astartrigger", 2);
}
