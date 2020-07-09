//::///////////////////////////////////////////////
//:: FileName sc_ac_daveyq5
//:: Check to see whether player completed painting
//::  quest for Vladmyr
//:: Created By: Anya Clancy
//:: Created On: 10/16/2005 2:09:55 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_davey_quest") == 5))
        return FALSE;

    return TRUE;
}
