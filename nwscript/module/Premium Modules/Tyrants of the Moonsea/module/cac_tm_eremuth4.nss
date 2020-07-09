//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_eremuth4
//:: DATE: March 4, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Eremuth conversation
//:: Make Eremuth available for hire
//::////////////////////////////////////////////////////

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "eremuthunlocked", 1);
}
