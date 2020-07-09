//::///////////////////////////////////////////////
//:: FileName sc_joukaquest1
//:: Check whether player is on Jouka quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 4/9/2006 5:18:33 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "ac_jouka_quest") == 1))
        return FALSE;

    return TRUE;
}
