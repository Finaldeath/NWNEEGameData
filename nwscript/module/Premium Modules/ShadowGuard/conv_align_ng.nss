//::///////////////////////////////////////////////
//:: FileName conv_align_ln
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/3/2003 2:58:39 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's alignment
    if(GetAlignmentGoodEvil(GetPCSpeaker()) != ALIGNMENT_GOOD)
        return FALSE;
    if(GetAlignmentLawChaos(GetPCSpeaker()) != ALIGNMENT_NEUTRAL)
        return FALSE;

    return TRUE;
}