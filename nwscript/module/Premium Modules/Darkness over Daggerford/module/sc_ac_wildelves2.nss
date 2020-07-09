//::///////////////////////////////////////////////
//:: FileName sc_ac_wildelves2
//:: Check to see if player killed Kyleena
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/17/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_wildelves_quest") == 2))
        return FALSE;

    return TRUE;
}
