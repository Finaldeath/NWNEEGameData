//::///////////////////////////////////////////////
//:: FileName sc_rumor3a
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/9/2005 1:24:19 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "rumor3a") != 1))
        return FALSE;

    return TRUE;
}
