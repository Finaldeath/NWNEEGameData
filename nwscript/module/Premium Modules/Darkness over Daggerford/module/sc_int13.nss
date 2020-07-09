//returns true if PC Int is 13 or more
//Author: Damian Brown (Luspr)
//Date: 27-Aug-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iInt = GetAbilityScore(oPC, ABILITY_INTELLIGENCE);
    if(iInt > 12 && GetLocalInt(OBJECT_SELF, "iIntCheck") == 0)
    return TRUE;
    return FALSE;
}
