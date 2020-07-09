//returns true if PC is a ranger or druid
//Author: Damian Brown
//Date: 27-Aug-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iRanger = GetLevelByClass(CLASS_TYPE_RANGER, oPC);
    int iDruid = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    if((iRanger > 0) || (iDruid > 0))
    return TRUE;//pc has a level of druid or ranger
    return FALSE;
}
