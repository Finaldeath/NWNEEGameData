//::///////////////////////////////////////////////
//:: FileName sc_ac_elvesdead
//:: See if player killed all the wild elves
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/22/2006 12:58:08 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "ac_elf_deaths") >= 8))
        return FALSE;

    return TRUE;
}
