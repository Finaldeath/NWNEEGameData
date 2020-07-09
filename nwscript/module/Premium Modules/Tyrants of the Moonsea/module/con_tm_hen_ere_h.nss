//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_hen_ere_h
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Checks whether Eremuth is currently hired.
//::////////////////////////////////////////////////////

#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = GetNearestObjectByTag("Eremuth", oPC);

    return (GetIsObjectValid(oHench) && HenchmanIsMine(oHench, oPC));
}
