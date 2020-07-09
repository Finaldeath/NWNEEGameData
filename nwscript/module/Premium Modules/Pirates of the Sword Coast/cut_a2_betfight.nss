//::///////////////////////////////////////////////
//:: The fight
//:: cut_a2_betfight.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cutscene for when the player bets on a
    fight in the warehouse.

    This is a unique setup. The cutscene
    end isn't called in this script. Instead,
    once everything is set up, the two fighters
    just bash each other, and the cutscene
    is ended by the OnDamaged script of the
    fighter who is supposed to lose.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 14/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    cs_SetDelayType(CS_DELAY_TYPE_TOTAL);

    // NPC's
    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip);
    object oFighter1 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER1);
    object oFighter2 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER2);
    HealFull(oFighter1);
    HealFull(oFighter2);

    // waypoints
    object oWP_Fighter1 = GetObjectByTagInArea(a2w_Warehouse_Fighter1);
    object oWP_Fighter2 = GetObjectByTagInArea(a2w_Warehouse_Fighter2);
    object oWP_Redtip = GetObjectByTagInArea(a2w_Warehouse_Redtip_Watch);

    // PC copy
    // should we bother?

    // jump fighters and Redtip to their waypoints
    cs_ActionJumpToObject(0.0, oFighter1, oWP_Fighter1);
    cs_ActionJumpToObject(0.0, oFighter2, oWP_Fighter2);
    cs_ActionJumpToObject(0.0, oRedtip, oWP_Redtip);

    // setup camera
    cs_CameraUseCameraWaypoint(0.1, 20);
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // start fight
    cs_ActionAttack(1.0, oFighter1, oFighter2, FALSE);
    cs_ActionAttack(1.0, oFighter2, oFighter1, FALSE);
    // this MUST be set back to FALSE in the end script
    DelayCommand(1.0, SetLocalInt(oRedtip, l_n_FIGHTCLUB_FIGHTACTIVE, TRUE));
}
