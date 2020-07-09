//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_astar4
//:: DATE: March 4, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Astar conversation
//:: Make Astar available for hire
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "astarunlocked", 1);
}
