//::///////////////////////////////////////////////
//:: FileName sc_ac_ckdavey1
//:: See if player on Davey quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_davey_quest") == 1))
        return FALSE;
    if((GetLocalInt(GetPCSpeaker(), "hallerans_ool") == 1))
        return FALSE;
    if((GetLocalInt(OBJECT_SELF, "this_node_once") == 1))
        return FALSE;

    return TRUE;
}

