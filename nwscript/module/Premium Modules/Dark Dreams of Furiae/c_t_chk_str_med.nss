// Returns whether the player PASSED a medium-difficulty str check
#include "ddf_util"
#include "nw_i0_plot"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iStr = GetAbilityScore( oPC, ABILITY_STRENGTH);
    int iStrBonus = (iStr - 10)/2;
    int iMediumDC = 15; // see https://5thsrd.org/rules/abilities/ability_checks/

    int iTotalRoll = d20() +  iStrBonus;

    debug("-- iStr: " + IntToString(iStr) + " iStrBonus: " + IntToString(iStrBonus) + " iTotalRoll: " + IntToString(iTotalRoll));

    if(iTotalRoll >= iMediumDC) return TRUE;
    return FALSE;
}
