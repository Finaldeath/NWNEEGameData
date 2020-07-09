//::///////////////////////////////////////////////
//:: FileName sc_ac_grtst_port
//:: See if player has portrait of Greatshout
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:19:38 PM
//:://////////////////////////////////////////////

int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetItemPossessedBy(oPC, "ac_portrait_grts") == OBJECT_INVALID)
    return FALSE;

    return TRUE;
}

