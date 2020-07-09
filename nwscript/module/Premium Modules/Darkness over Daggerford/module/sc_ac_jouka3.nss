//::///////////////////////////////////////////////
//:: FileName sc_ac_jouka3
//:: See whether player has completed Jouka quest
//:://////////////////////////////////////////////
//:: Created By:  Anya Clancy
//:: Created On: 4/9/2006 5:25:31 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_jouka_quest") == 3))
        return FALSE;

    return TRUE;
}
