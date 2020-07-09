//::///////////////////////////////////////////////
//:: FileName sc_ac_taffy_door
//:: Check to see if Taffy (Mariner Guard) opened door
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/30/2005 3:12:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_taffy_opendoor") == 1))
        return FALSE;

    return TRUE;
}
