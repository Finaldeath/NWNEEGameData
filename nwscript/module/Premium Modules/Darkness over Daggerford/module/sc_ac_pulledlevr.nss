//::///////////////////////////////////////////////
//:: FileName sc_ac_pulledlevr
//:: See if player pulled lever to open cage
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/11/2005 2:36:51 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "pulled_lever") == 1))
        return FALSE;

    return TRUE;
}
