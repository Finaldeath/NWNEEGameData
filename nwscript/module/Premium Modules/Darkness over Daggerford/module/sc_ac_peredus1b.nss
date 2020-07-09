//::///////////////////////////////////////////////
//:: FileName sc_ac_peredus1
//:: See whether is on Peredus' quest and has bones
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 11/20/2005 12:46:27 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    object oPC = GetPCSpeaker();
    object oB = GetItemPossessedBy(oPC,"ac_perebones");

    if(!(GetLocalInt(oPC,"ac_peredus") == 1))
        return FALSE;
    if(!(GetIsObjectValid(oB) == TRUE))
        return FALSE;

    return TRUE;
}
