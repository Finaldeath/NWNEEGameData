//::///////////////////////////////////////////////
//:: The fight (end script)
//:: cut_a2_betfighte.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cutscene for when the player bets on a
    fight in the warehouse.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 14/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip);
    object oFighter1 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER1);
    object oFighter2 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER2);

    // reset fight variables
    SetLocalInt(oRedtip, l_n_FIGHTCLUB_FIGHTACTIVE, FALSE);
    SetLocalInt(oFighter1, l_n_FIGHTCLUB_PARTICIPANT, l_nv_FIGHTCLUB_PARTICIPANT_NOT);
    SetLocalInt(oFighter2, l_n_FIGHTCLUB_PARTICIPANT, l_nv_FIGHTCLUB_PARTICIPANT_NOT);
    // heal the fighters
    HealFull(oFighter1);
    HealFull(oFighter2);
    // stop the fight
    SetPlotFlag(oFighter1, TRUE);
    SetPlotFlag(oFighter2, TRUE);
    AssignCommand(oFighter1, ClearAllActions(TRUE));
    AssignCommand(oFighter2, ClearAllActions(TRUE));

    // restore the fighter's positions
    location lFighter1 = GetLocalLocation(oRedtip, l_l_FIGHTCLUB_ORIG_POS_FIGHTER1);
    location lFighter2 = GetLocalLocation(oRedtip, l_l_FIGHTCLUB_ORIG_POS_FIGHTER2);
    DelayCommand(0.1, AssignCommand(oFighter1, ActionJumpToLocation(lFighter1)));
    DelayCommand(0.1, AssignCommand(oFighter2, ActionJumpToLocation(lFighter2)));

    // did player win bet?
    int bFighter1Won = GetLocalInt(oRedtip, l_n_FIGHTCLUB_PLAYER_WON_BET);
    // if so, give the player their winnings. If for some reason, the player
    // object who made the bet is invalid (ie. disconnected), search for the
    // first valid player in the area, and give them the money. If nobody
    // else is in the area, well, tough luck.
    object oPC = GetLocalObject(oRedtip, l_o_FIGHTCLUB_BETTING_PLAYER);
    if(!GetIsObjectValid(oPC))
    {
        oPC = GetPCInArea();
    }
    if(GetIsObjectValid(oPC))
    {
        if(bFighter1Won)
        {
            GiveGoldToCreature(oPC, 200);
        }

        object oWP_PC = GetObjectByTagInArea(a2w_Warehouse_Player_Watch);
        AssignCommand(oPC, ActionJumpToObject(oWP_PC));

        SetLocalInt(oRedtip, l_n_FIGHTCLUB_REDTIP_SAY_1LINER, TRUE);
        DelayCommand(1.0, AssignCommand(oRedtip, ActionStartConversation(oPC)));
    }
}
