//::///////////////////////////////////////////////
//:: FileName con_sharalyn10
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 17/10/2018 23:47:21
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE) >= 10))
        return FALSE;

    return TRUE;
}
