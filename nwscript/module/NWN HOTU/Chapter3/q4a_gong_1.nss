//::///////////////////////////////////////////////
//:: FileName q4a_gong_0
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/15/2003 12:53:05 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "q4a_gong_ear") == 1))
        return FALSE;

    return TRUE;
}