#include "inc_global"
#include "x0_i0_henchman"

// use l_nv_REDTIP_BRAWL_OUTCOME_* variables for nOutcome
void RedtipEndBrawl(int nOutcome, object oRedtip=OBJECT_SELF);

void RedtipEndBrawl(int nOutcome, object oRedtip=OBJECT_SELF)
{
    // failsafe - if for some reason this function is called without
    // the brawl variable set, just abort
    if(!GetLocalInt(oRedtip, l_n_REDTIP_BRAWL_ON)) return;

    SetLocalInt(oRedtip, l_n_REDTIP_BRAWL_ON, FALSE);
    SetLocalInt(oRedtip, l_n_REDTIP_BRAWL_OUTCOME, nOutcome);
    SetPlotFlag(oRedtip, TRUE);
    SetImmortal(oRedtip, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oRedtip)), oRedtip);

    AssignCommand(oRedtip, SurrenderToEnemies());

    DelayCommand(2.0, ChangeToStandardFaction(oRedtip, STANDARD_FACTION_COMMONER));

    /*
    object oWP = GetObjectByTagInArea(a2w_Warehouse_Redtip_Base_Position);
    if(GetDistanceBetween(oRedtip, oWP) > 4.0)
    {
        AssignCommand(oRedtip, ActionMoveToObject(oWP, FALSE, 0.3));
        AssignCommand(oRedtip, ActionDoCommand(SetFacing(GetFacing(oWP))));
    }
    */
    object oPC = GetLocalObject(oRedtip, l_o_REDTIP_BRAWL_PLAYER_OBJECT);
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oRedtip, ClearAllActions(TRUE));
    DelayCommand(1.0, ActionStartConversation(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC)));

    // if the player won the fight, set the proper plot variable
    if(nOutcome==l_nv_REDTIP_BRAWL_OUTCOME_WON) SetLocalInt(GetModule(), "A2_REDTIP", 30);

    // restore henchmen
    object oHench1 = GetLocalObject(oRedtip, l_o_REDTIP_BRAWL_HENCH1);
    object oHench2 = GetLocalObject(oRedtip, l_o_REDTIP_BRAWL_HENCH2);
    if(GetIsObjectValid(oHench1) && !GetIsObjectValid(GetMaster(oHench1))) HireHenchman(oPC, oHench1);
    if(GetIsObjectValid(oHench2) && !GetIsObjectValid(GetMaster(oHench2))) HireHenchman(oPC, oHench2);
}

