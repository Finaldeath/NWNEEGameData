//returns true if PC is a monk or paladin
//Author: Alan Tarrant as adapted from Damian Brown's Druid-Ranger script.
//Date: 30-Nov-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    int iMonk = GetLevelByClass(CLASS_TYPE_MONK, oPC);
    if((iPaladin > 0) || (iMonk > 0))
    return TRUE;//pc has a level of monk or paladin
    return FALSE;
}
