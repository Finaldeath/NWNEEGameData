//::///////////////////////////////////////////////
//:: FileName sc_ac_wildelves3
//:: Check to see if player convinced Kyleena to leave
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/17/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_wildelves_quest") >= 3))
        return FALSE;

    return TRUE;
}
