//::///////////////////////////////////////////////
//:: FileName sc_ac_sistersdea
//:: See if sisters are dead
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 2/5/2006 1:15:35 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "sisters_dead") == 1))
        return FALSE;

    return TRUE;
}
