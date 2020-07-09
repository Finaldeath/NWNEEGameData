//::///////////////////////////////////////////////
//:: FileName sc_ac_insight
//:: See if player's intelligence > 12 (capable of insight)
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 4:07:10 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE) > 12))
        return FALSE;

    return TRUE;
}
