//::///////////////////////////////////////////////
//:: Warehouse cutscene (end script)
//:: cut_a2_wareh.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cutscene that fires the first the player
    enters the warehouse, where they meet Redtip.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 10/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    SetLocalInt(GetObjectByTagInArea(a2c_tag_Redtip), l_n_REDTIP_CUTSCENE_DONE, TRUE);

    // cs_ActionAttack doesn't automatically abort properly, so a simple
    // ClearAllActions should clear it up
    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip);
    AssignCommand(oRedtip, ClearAllActions(TRUE));

    // also make Redtip init dialogue
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oRedtip);
    DelayCommand(1.0, AssignCommand(oRedtip, ActionStartConversation(oPC)));

    // Redtip's opponent will get up and walk to a waypoint
    object oFighterWP = GetObjectByTagInArea(a2w_Warehouse_Redtip_Opponent_End);
    object oFighter = GetObjectByTagInArea(a2c_tag_Redtip_Fighter);

    DelayCommand(3.0, AssignCommand(oFighter, ClearAllActions(TRUE)));
    DelayCommand(3.1, AssignCommand(oFighter, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 1.5)));
    DelayCommand(4.8, AssignCommand(oFighter, ActionMoveToObject(oFighterWP)));
    DelayCommand(4.9, AssignCommand(oFighter, ActionDoCommand(SetFacing(GetFacing(oFighterWP)))));

    DelayCommand(4.8, SetLocalInt(oFighter, "GOING_TO_WP", TRUE));
}
