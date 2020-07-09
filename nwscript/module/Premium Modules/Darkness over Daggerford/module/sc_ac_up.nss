//::///////////////////////////////////////////////
//:: FileName sc_ac_up_rand
//:: See whether sisters are upstairs
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/22/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetTag(GetArea(GetObjectByTag("ac_muriel"))) == "C1AR0701BWealthyHouseUpperFloor"))
        return FALSE;

    return TRUE;
}
