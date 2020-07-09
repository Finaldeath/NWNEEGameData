//::///////////////////////////////////////////////
//:: FileName sc_ac_killroo
//:: See if player killed Roo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 8:43:02 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_rookill") == 1))
        return FALSE;

    return TRUE;
}
