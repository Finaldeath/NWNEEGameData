//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_wis10
// DATE: September 15, 2005
// AUTH: Luke Scull
// NOTE: Text appears when wisdom 10+
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

int StartingConditional()
{

    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "garthxp") >= 1) return FALSE;

    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_WISDOM) >= 10))
        return FALSE;

    return TRUE;
}
