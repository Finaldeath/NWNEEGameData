//returns true if PC Int is 16 or more
//Author: Damian Brown (Luspr)
//Date: 27-Aug-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iInt = GetAbilityScore(oPC, ABILITY_INTELLIGENCE);
    if(iInt > 15)
    return TRUE;
    return FALSE;
}
