//::///////////////////////////////////////////////
//:: FileName sc_ac_upstairs
//:: See whether sisters are upstairs
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetTag(GetArea(GetPCSpeaker())) == "C1AR0701BWealthyHouseUpperFloor"))
        return FALSE;

    return TRUE;
}
