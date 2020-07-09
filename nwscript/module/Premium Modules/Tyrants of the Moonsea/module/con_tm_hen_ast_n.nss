//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_hen_ast_h
//:: DATE: February 16, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Checks whether Astar is currently hired.
//::////////////////////////////////////////////////////

#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = GetNearestObjectByTag("Astar", oPC);

    return (GetIsObjectValid(oHench) && HenchmanIsMine(oHench, oPC));
}

