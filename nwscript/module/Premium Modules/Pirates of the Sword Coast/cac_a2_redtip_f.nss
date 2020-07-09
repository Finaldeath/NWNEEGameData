//::///////////////////////////////////////////////
//:: cac_a2_redtip_f
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Player has chosen to fight Redtip.

    Insert obligatory "Let's get ready to
    rumble" sound here.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 10/05
//:://////////////////////////////////////////////
#include "inc_redtip"
#include "nw_i0_plot"

void StartBrawl(object oPC);

void main()
{
    // OBJECT_SELF = Redtip
    object oPC = GetPCSpeaker();
    object oArea = GetArea(OBJECT_SELF);

    // store which player is going to be in the fight
    SetLocalObject(OBJECT_SELF, l_o_REDTIP_BRAWL_PLAYER_OBJECT, oPC);

    // store the henchmen objects
    object oHench1 = GetHenchman(oPC, 1);
    object oHench2 = GetHenchman(oPC, 2);
    SetLocalObject(OBJECT_SELF, l_o_REDTIP_BRAWL_HENCH1, oHench1);
    SetLocalObject(OBJECT_SELF, l_o_REDTIP_BRAWL_HENCH2, oHench2);

    // remove henchmen from party, move to watch waypoints
    if(GetIsObjectValid(oHench1))
    {
        FireHenchman(oPC, oHench1);
        AssignCommand(oHench1, ClearAllActions(TRUE));
        AssignCommand(oHench1, ActionJumpToObject(GetObjectByTag(a2w_Warehouse_Hench1_Watch)));
    }
    if(GetIsObjectValid(oHench2))
    {
        FireHenchman(oPC, oHench2);
        AssignCommand(oHench2, ClearAllActions(TRUE));
        AssignCommand(oHench2, ActionJumpToObject(GetObjectByTag(a2w_Warehouse_Hench2_Watch)));
    }

    // set the brawl state variable
    SetLocalInt(OBJECT_SELF, l_n_REDTIP_BRAWL_ON, TRUE);

    // If Redtip and the player are close enough to the center of the ring
    // we'll just start the fight. Otherwise we'll do a quick fade out/in
    // and reset their positions.
    object oWP_Redtip = GetObjectByTagInArea(a2w_Warehouse_Fighter1,oArea);
    object oWP_Player = GetObjectByTagInArea(a2w_Warehouse_Fighter2,oArea);
    object oWP_Center = GetObjectByTagInArea(a2w_Warehouse_Ring_Center,oArea);

    if( (GetDistanceBetween(OBJECT_SELF, oWP_Center) > 2.5) ||
        (GetDistanceBetween(oPC, oWP_Center) > 2.5))
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        AssignCommand(oPC, ClearAllActions(TRUE));
        ClearAllActions(TRUE); // on Redtip

        DelayCommand(0.5, AssignCommand(oPC, ActionJumpToObject(oWP_Player)));
        DelayCommand(0.5, ActionJumpToObject(oWP_Redtip));

        DelayCommand(1.0, FadeFromBlack(oPC, FADE_SPEED_FASTEST));
        DelayCommand(1.1, StartBrawl(oPC));
    }
    else
    {
        StartBrawl(oPC);
    }
}

void StartBrawl(object oPC)
{
    // make Redtip immortal, and not plot
    SetImmortal(OBJECT_SELF, TRUE);
    SetPlotFlag(OBJECT_SELF, FALSE);
    // oh yeah, and heal him too
    int nHeal = GetMaxHitPoints()-GetCurrentHitPoints();
    if(nHeal>0)
    {
        effect eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
    }

    // make sure Redtip has his weapon equipped
    if(!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)))
    {
        object oWeapon = GetFirstItemInInventory();
        int bFoundWeapon = FALSE;
        while(GetIsObjectValid(oWeapon))
        {
            if(MatchMeleeWeapon(oWeapon))
            {
                ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND);
                bFoundWeapon = TRUE;
                break;
            }
            oWeapon = GetNextItemInInventory();
        }
        // didn't find a weapon? Ok, spawn in a trident and equip that
        if(!bFoundWeapon)
        {
           oWeapon = CreateItemOnObject("sahaugintrident");
           ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND);
        }
    }

    // make PC immortal, set hostilities
    SetImmortal(oPC, TRUE);
    SetPlotFlag(oPC, FALSE); // just in case
    //DelayCommand(0.5, SetIsTemporaryEnemy(OBJECT_SELF, oPC));
    //DelayCommand(0.5, SetIsTemporaryEnemy(oPC, OBJECT_SELF));
    DelayCommand(0.5, ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));

    DelayCommand(0.6, ActionAttack(oPC));

}
