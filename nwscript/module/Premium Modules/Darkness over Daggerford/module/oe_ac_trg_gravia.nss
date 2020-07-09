//::///////////////////////////////////////////////
//:: FileName oe_ac_trg_gravia
//:: Gravia starts conversation with you when you come back from maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    object oPC = GetEnteringObject();
    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
    if(GetLocalInt(oPC,"been_in_maze")!=1) return;

    object oGravia = GetObjectByTag("ac_gravia");
    SetLocalInt(OBJECT_SELF,"fired",1);
    AssignCommand(oGravia, ClearAllActions());
    AssignCommand(oGravia, ActionStartConversation(oPC));
    AssignCommand(oGravia, ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oGravia)));
    AssignCommand(oGravia, ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_INITIALIZED, FALSE, oGravia)));
}
