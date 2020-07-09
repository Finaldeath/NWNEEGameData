//::///////////////////////////////////////////////
//:: FileName sc_ac_plagueq3
//:: See whether player convinced Daxiong to "move on"
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:28:19 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_plague_quest") == 3))
        return FALSE;

    return TRUE;
}
