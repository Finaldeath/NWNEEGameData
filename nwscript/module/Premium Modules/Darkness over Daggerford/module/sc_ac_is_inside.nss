//::///////////////////////////////////////////////
//:: FileName sc_ac_is_outside
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/10/2005 5:24:35 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetIsAreaInterior(GetArea(OBJECT_SELF))))
        return FALSE;

    if(!(GetLocalInt(OBJECT_SELF,"has_met_pc")==1))
    return FALSE;

    return TRUE;
}
