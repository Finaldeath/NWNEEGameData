//::///////////////////////////////////////////////
//:: FileName sc_ac_plagueq4
//:: See if quest completion has been acknowledged by Liam
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 3:55:39 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_plague_quest") == 4))
        return FALSE;

    return TRUE;
}
