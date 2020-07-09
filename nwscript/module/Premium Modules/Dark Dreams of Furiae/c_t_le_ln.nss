#include "ddf_util"

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_background_flag") == BG_COP || GetLocalInt(GetModule(), "ddf_background_flag") == BG_INDIE) return FALSE;

    object oPC = GetPCSpeaker();

    int iLawful = GetAlignmentLawChaos(oPC);
    int iGood = GetAlignmentGoodEvil(oPC);

    if(iLawful == ALIGNMENT_LAWFUL && (iGood == ALIGNMENT_EVIL || iGood == ALIGNMENT_NEUTRAL)) return TRUE;

    return FALSE;
}
