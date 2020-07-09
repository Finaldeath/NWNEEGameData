//::///////////////////////////////////////////////
//:: FileName sc_ac_oathbond
//:: Check to see if Nosfiraat gave oathbond to PC
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 4/29/2005 10:36:36 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_oathbond") == 1))
        return FALSE;

    return TRUE;
}
