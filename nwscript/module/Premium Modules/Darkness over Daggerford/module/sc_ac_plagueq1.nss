//::///////////////////////////////////////////////
//:: FileName sc_ac_plagueq1
//:: Checker whether player is on plague quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:04:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_plague_quest") >= 1))
        return FALSE;

    return TRUE;
}
