//::///////////////////////////////////////////////
//:: FileName sc_ac_daveyq4
//:: See if agreed to give Vlad gold for Davey's quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 2:20:31 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_davey_quest") == 4))
        return FALSE;

    return TRUE;
}
