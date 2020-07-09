//::///////////////////////////////////////////////
//:: FileName sc_npc_hasmet1
//:: See whether player has met this NPC
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 2:15:31 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(!(GetLocalInt(OBJECT_SELF,"has_met_pc")==1))
    return FALSE;
    return TRUE;
}
