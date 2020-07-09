//::///////////////////////////////////////////////
//:: FileName sc_ac_plagueq1
//:: Checker whether player spoke with kyleena about music
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:04:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_kyleena_music") == 1))
        return FALSE;

    return TRUE;
}
