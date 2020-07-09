//::///////////////////////////////////////////////
//:: FileName sc_ac_wildelves1
//:: Check to see if player is on wild elves quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    int n = GetLocalInt(GetPCSpeaker(), "ac_wildelves_quest");
    if ( n >= 1 && n < 4)
        return TRUE;

    return FALSE;
}
