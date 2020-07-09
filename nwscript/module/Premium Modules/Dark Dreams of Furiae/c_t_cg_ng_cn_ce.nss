#include "ddf_util"

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_REVOLUTIONARY || GetLocalInt(GetModule(), "ddf_background_flag") == BG_INDIE) return FALSE;

    object oPC = GetPCSpeaker();

    // Chaotic good
    // Chaotic neutral
    // Chaotic evil
    int iLawChaos = GetLawChaosValue(oPC);
    int iGoodEvil = GetGoodEvilValue(oPC);

    int iL = GetAlignmentLawChaos(oPC);
    int iG = GetAlignmentGoodEvil(oPC);

    debug("iLawChaos: " + IntToString(iLawChaos) + " (" + IntToString(iL) + "), iGoodEvil: " + IntToString(iGoodEvil) + " (" + IntToString(iG) + ")");

    // neutral good
    if(iL == ALIGNMENT_NEUTRAL && iG == ALIGNMENT_GOOD) return TRUE;

    if(iL == ALIGNMENT_CHAOTIC) return TRUE;

    return FALSE;

}
