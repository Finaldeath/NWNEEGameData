//::///////////////////////////////////////////////
//:: FileName sc_ac_plagueq2
//:: See whether player killed Daxiong
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:28:19 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_plague_quest") == 2))
        return FALSE;

    return TRUE;
}