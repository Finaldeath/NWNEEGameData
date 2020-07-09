//returns true if PC Int is 13 or more
//Author: Damian Brown (Luspr)
//Date: 27-Aug-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iWis = GetAbilityScore(oPC, ABILITY_WISDOM);
    if(iWis > 12)
    return TRUE;
    return FALSE;
}
