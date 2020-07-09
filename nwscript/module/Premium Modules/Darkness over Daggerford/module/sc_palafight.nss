//returns true if PC is a paladin or fighter
//Author: Alan Tarrant (revision of Damian's Ranger-Druid script)
//Date: 04-Dec-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    int iFighter = GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
    if((iPaladin > 0) || (iFighter > 0))
    return TRUE;//pc has a level of paladin or fighter
    return FALSE;
}
