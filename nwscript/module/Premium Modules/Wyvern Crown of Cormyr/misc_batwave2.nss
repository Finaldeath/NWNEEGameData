//::///////////////////////////////////////////////
//:: misc_batwave2
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Second wave of Witch Lord's forces arrive.
*/
//:://////////////////////////////////////////////
//:: Create By: B W-Husey
//:: Created On: January 2006
//:://////////////////////////////////////////////
// Lots of changes 9th April
// Gale - 12 April 2006: Changing jonas tag, to allow it to follow the proper post
// Modified B W-Husey 17th April - Changed back Tag, adjusted movement scripts

// Syrsnein, 24 April 2006: modified to use a different method to start the escape
//  cutscene.
// Syrsnein, 17 June 2006: modified to prevent Jonas from using the axe during
//  the battle.
// B W-Husey, 18 June 2006: moved Jonas start waypoint to be next to the WL for better visibility

#include "cu_functions"
//include "dla_i1_battle"

void main()
{
    location lLeft = GetLocation(GetWaypointByTag("WP_EnemyLeft"));
    location lRight = GetLocation(GetWaypointByTag("WP_EnemyRight"));
    int nCount=0;

    while (nCount < 2)
      {
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGS",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleHGS",lRight,FALSE,"EnemyRight");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleSkel",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleSkel",lRight,FALSE,"EnemyRight");
        nCount++;
      }
             CreateObject(OBJECT_TYPE_CREATURE,"BattleSpec",lLeft,FALSE,"EnemyLeft");
             CreateObject(OBJECT_TYPE_CREATURE,"BattleSpec",lRight,FALSE,"EnemyRight");

    CreateObject(OBJECT_TYPE_CREATURE,"BattleHGL",lLeft,FALSE,"EnemyLeft");
    CreateObject(OBJECT_TYPE_CREATURE,"BattleOS",lRight,FALSE,"EnemyRight");

    object oArea = GetAreaFromLocation(lLeft);
    object oPC = GetLocalObject(oArea, "oPC");
    object oWitch = CreateObject(OBJECT_TYPE_CREATURE,"BattleWL",lRight);
    object oJonas;
    object oDirector = GetObjectByTag("SceneDirector");

//    FloatingTextStringOnCreature("spawn", oPC, FALSE);
    SetLocalObject(oArea,"BattleWL",oWitch);
    oJonas = JonasRace(GetRacialType(oPC), lRight, "Jonas");
    // Syrsnein, 17 June 2006: destroy the axe if it exists in oJonas' inventory.
    DestroyObject(GetItemPossessedBy(oJonas, "NW_WAXHN001"));
    ChangeToStandardFaction(oJonas, STANDARD_FACTION_HOSTILE);
    DLA_Mount(oJonas, OBJECT_INVALID, FALSE, DLA_HORSE5_TAIL_BARDING2);
    AdjustAlignment(oJonas, ALIGNMENT_EVIL, 100);
    DelayCommand(0.1, LevelHenchmanUpTo(oJonas,GetHitDice(oPC)));

    SetLocalObject(oArea, "oJonas", oJonas);
    SetLocalInt(oJonas, "Battlefield", 1);

    AssignCommand(oJonas, ActionEquipItem(CreateItemOnObject("blackknight",  oJonas), INVENTORY_SLOT_CHEST));
    AssignCommand(oJonas, ActionEquipItem(CreateItemOnObject("blackshield",  oJonas), INVENTORY_SLOT_LEFTHAND));
    AssignCommand(oJonas, ActionEquipItem(CreateItemOnObject("blackhelm",    oJonas), INVENTORY_SLOT_HEAD));
    AssignCommand(oJonas, ActionEquipItem(CreateItemOnObject("blacksword", oJonas), INVENTORY_SLOT_RIGHTHAND));
    AssignCommand(oJonas, ActionEquipItem(CreateItemOnObject("thewitchring", oJonas), INVENTORY_SLOT_LEFTRING));
    AssignCommand(oJonas, ActionEquipItem(CreateItemOnObject("ridersring",   oJonas), INVENTORY_SLOT_RIGHTRING));
    AssignCommand(oJonas, ActionMoveToLocation(GetLocation(GetWaypointByTag("POST_EnemyLeft")),TRUE));
    AssignCommand(oJonas, ActionEquipMostDamagingMelee());
    CreateItemOnObject("nw_it_mpotion002", oJonas, 3);
    SetImmortal(oJonas, TRUE);
    DelayCommand(5.1,AssignCommand(oJonas,ActionMoveToLocation(GetLocation(GetWaypointByTag("POST_EnemyLeft")),TRUE)));

//    DelayCommand(IntToFloat(GetLocalInt(oArea, "Delay")), DoWLLeavingCutscene(oPC));
// Syrsnein, replaced the line above with a new call to start the escape cutscene.
    DelayCommand(IntToFloat(GetLocalInt(oArea, "Delay")), SignalEvent(oDirector, EventUserDefined(DLA_EVENT_BARROWEXIT)));

    object oCleric = GetObjectByTag("BattlePDKC");

    //Some spellcasters do some actions to protect themselves/troops
    AssignCommand(oWitch,ClearAllActions());
    AssignCommand(oWitch,ActionCastSpellAtObject(SPELL_STONESKIN,OBJECT_SELF,METAMAGIC_ANY,TRUE,15,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
    AssignCommand(oWitch,ActionCastSpellAtObject(SPELL_SPELL_MANTLE,OBJECT_SELF,METAMAGIC_ANY,TRUE,15,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
//    AssignCommand(oCleric,ClearAllActions());
//     AssignCommand(oCleric,ActionCastSpellAtObject(SPELL_REMOVE_FEAR,OBJECT_SELF,METAMAGIC_ANY,TRUE,15,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
    //Start the Witch Lord moving
    DelayCommand(10.0, AssignCommand(oWitch, ActionMoveToObject(GetNearestEnemy(),TRUE)));
    DelayCommand(10.1, AssignCommand(oJonas, ActionMoveToObject(oPC,TRUE)));
}
