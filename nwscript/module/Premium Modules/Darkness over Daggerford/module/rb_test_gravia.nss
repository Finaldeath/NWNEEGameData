#include "x0_i0_walkway"

void main()
{
    object oPC = GetPCSpeaker();
    object oGravia = GetObjectByTag("ac_gravia");
    object oWG = GetWaypointByTag("POST_ac_gravia");

    SetLocalInt(GetObjectByTag("ac_gravia"), "no_banter", 1);
    SetLocalInt(GetModule(), "ac_werewolf", 4);
    SetLocalInt(oPC,"been_in_maze", 1);

    AssignCommand(oGravia, ClearAllActions());
    AssignCommand(oGravia, ActionJumpToObject(oWG));
    //AssignCommand(oGravia, ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oGravia)));
   // AssignCommand(oGravia, ActionDoCommand(SetWalkCondition(NW_WALK_FLAG_INITIALIZED, FALSE, oGravia)));
}
