//::///////////////////////////////////////////////
//:: dla_i1_battle
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    OnUserDefinedEvent include file for the barrow battlefield cutscene
    when the Witch Lord and Jonas escape.

    Note: most of this is derived from Gale's dla_i0_battle as a replacement
    to stamp out the jumping bug.
*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: April 24, 2006
//:://////////////////////////////////////////////

//Comments from dla_i0_battle
// Modified B W-Husey 2nd April to change tag location of Jonas' jump point, and enforce jumping
// and to switch Jonas and WL factions & mortality flags.

// Gale - April 12, 2006: Fixed leveling up jonas to PC level
// Fixed WL / Jonas becoming neutral after leaving (he was not)
// Still needing to fix it to make them really leave always.

// Modified B W-Husey 17th April - fixes to faction script for henchmen. Add journal entries. Fixes to jumping scripts
// Jonas changed back to cutscene immobile


#include "cu_functions"

void DLA_DestroyObject(object oObject)
{
    if (!GetIsObjectValid(oObject)) return;
    object oItem = GetFirstItemInInventory(oObject);
    while (GetIsObjectValid(oItem))
    {
        if (GetHasInventory(oItem))
        {
            DLA_DestroyObject(oItem);
        }
        SetPlotFlag(oItem, FALSE);
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oObject);
    }

    if (GetObjectType(oObject) == OBJECT_TYPE_CREATURE)
    {
        int i;
        for (i=0;i<18;i++)
        {
            object oTemp;
            if (GetIsObjectValid(oTemp))
            {
                SetPlotFlag(oTemp, FALSE);
                DestroyObject(oTemp);
            }
        }
    }
    DestroyObject(oObject);
}

// Heal oCreature to half of it's hitpoints if it is currently less than half.
void HealToHalfHP(object oCreature)
{
   int nHalfHP = GetMaxHitPoints(oCreature)/2;
   if (GetCurrentHitPoints(oCreature) < nHalfHP)
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHalfHP), oCreature);
}

// Jump oCreature to a waypoint with the tag sWaypoint
void JumpToWaypointByTag(string sWaypoint, object oCreature = OBJECT_SELF)
{
    object oWaypoint = GetWaypointByTag(sWaypoint);
    if (GetIsObjectValid(oWaypoint) && GetIsObjectValid(oCreature))
    {
        DelayCommand(0.0, AssignCommand(oCreature, ClearAllActions(TRUE)));
        DelayCommand(0.1, AssignCommand(oCreature, JumpToObject(oWaypoint)));
    }
}

void ExitCleanupWL(object oWL)
{
    // Set up Witch Lord for next encounter
    HealToHalfHP(oWL);
    // Make the Witch Lord vulnerable and killable.
    SetPlotFlag(oWL, FALSE);
    SetImmortal(oWL, FALSE);
    // Stop prespawn effects (not sure why this is needed here).
    DeleteLocalInt(oWL, "cEffect"); //stop the prespawned effects
}

// Remove the Witch Lord from the battlefield
//  Called from the UserDefined event script for the Witchlord.
void ExitBattleWL(object oWL)
{
    object oPC = GetLocalObject(GetArea(OBJECT_SELF), "oPC");
    // Set the Witch Lord to be invulnerable - clean up in ExitCleanupWL.
    SetPlotFlag(oWL, TRUE);
    // Visual effects for leaving.
    effect eVis1 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eVis2 = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    // Visual effects for camera work.
    effect eCSG = EffectCutsceneGhost();
    effect eCSI = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect eLink = EffectLinkEffects(eCSG, eCSI);

    // Set up copy of Witch Lord.
    location lLoc = GetLocation(GetWaypointByTag("WP_WLEnd"));
    object oWL2 = CopyObject(oWL, lLoc);

    // Get the distance between us and the Witch Lord
    float fDist = GetDistanceBetween(oPC, oWL);

    // Start the cutscene.
    AssignCommand(oWL, ClearAllActions(TRUE));
    AssignCommand(oPC, ClearAllActions(TRUE));
    if (!GetCutsceneMode(oPC)) SetCutsceneMode(oPC, TRUE);
    // If the Witchlord is away from us, jump to him.
    if (fDist > 5.0)
    {
        // Store our current location
        SetLocalLocation(oPC, "lStartLoc", GetLocation(oPC));
        FadeToBlack(oPC, FADE_SPEED_FASTEST);
        // Store our camera facing
        StoreCameraFacing();
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPC));
        DelayCommand(1.4, AssignCommand (oPC, ActionJumpToObject(oWL)));
        DelayCommand(1.5, FadeFromBlack (oPC,FADE_SPEED_FASTEST));
        DelayCommand(3.9, FadeToBlack(oPC, FADE_SPEED_FASTEST));
        // Clear our invisibility effects
        DelayCommand(4.2, AssignCommand(oPC, JumpToLocation(GetLocalLocation(oPC, "lStartLoc"))));
        DelayCommand(4.3, RemoveEffect(oPC, eLink));
        DelayCommand(4.4, RestoreCameraFacing());
        DelayCommand(4.5, FadeFromBlack(oPC, FADE_SPEED_FASTEST));
    }
    // Exit Witchlord stage left
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oWL));
    DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oWL));
    DelayCommand(2.8, SetPlotFlag(oWL, FALSE));
    DelayCommand(2.9, SetImmortal(oWL, FALSE));
    DelayCommand(3.0, DLA_DestroyObject(oWL));

    // End cutscene.
    DelayCommand(4.6, SetCutsceneMode(oPC, FALSE));
    // Cleanup the Witch Lord and prepare him for our next encounter.
    DelayCommand(5.0, ExitCleanupWL(oWL2));
}

void ExitCleanupJonas(object oJonas)
{
    // Set up Jonas for the next encounter.
    effect eParalz    = EffectCutsceneImmobilize();
    effect eVFXParalz = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eLink      = EffectLinkEffects(eVFXParalz, eParalz);

    DLA_Dismount(oJonas, FALSE);
    // Make Jonas unable to go anywhere.
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oJonas);
    HealToHalfHP(oJonas);
    // Make Jonas vulnerable and killable for the PC to kill if he/she so wishes.
    SetPlotFlag(oJonas, FALSE);
    SetImmortal(oJonas, FALSE);
}

// Remove Jonas from the battlefield.
//  Called from the UserDefined Event script of Jonas
//Syrsnein 26 April, 2006: changed how affects are applied and removed delay
//  on jump.
void ExitBattleJonas(object oJonas)
{
    // Set Jonas as invulnerable - clean this up in ExitCleanupJonas.
    SetPlotFlag(oJonas, TRUE);
    // Effects to exit out with.
    effect eVis1 = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eVis2 = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    location lLoc = GetLocation(GetWaypointByTag("WP_EndJonas"));
    object oJonas2 = CopyObject(oJonas, lLoc);

    DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oJonas));
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oJonas));
    DelayCommand(0.7, AssignCommand(oJonas, SetIsDestroyable(TRUE)));
    DelayCommand(0.8, SetPlotFlag(oJonas, FALSE));
    DelayCommand(0.9, SetImmortal(oJonas, FALSE));
    DelayCommand(1.0, DLA_DestroyObject(oJonas));
    // Cleanup and prepare Jonas for the next encounter.
    DelayCommand(2.0, ExitCleanupJonas(oJonas2));
}

// Main function that is called from the OnDamaged event script of Jonas or
// the witch lord.
void ExitBattle()
{
    object oPC = GetLocalObject(GetArea(OBJECT_SELF), "oPC");
    if (GetLocalInt(oPC, "nBattleOver"))
        return;
    AllParty("nBattleOver", oPC, 1);
    object oArea     = GetArea(oPC);
    object oJonas    = GetLocalObject(oArea, "oJonas"  );
    object oWL       = GetLocalObject(oArea, "BattleWL");
    object oCal      = GetObjectByTag("Caladnei");
    object oMarker   = GetObjectByTag("FactionMarker");
    object oDirector = GetObjectByTag("SceneDirector");

    SetLocalInt(oJonas, "Battlefield", 2);
    // Clear reputations so that the player and the NPCs are trying to kill each
    //  other
    ClearPersonalReputationWithFaction(oPC, oJonas);
    ClearPersonalReputationWithFaction(oPC, oWL);
    // Change Jonas to be neutral to/against Defenders
    SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 85, oJonas);
    // Change Jonas' faction to Plot Neutral
    ChangeFaction(oJonas, oMarker);
    // Signal Jonas to run his exit event
    SignalEvent(oDirector, EventUserDefined(DLA_EVENT_BARROWEXIT_JONAS));
    // Change Witch Lord to be neutral to/against Defenders
    SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 85, oWL);
    // Change Witch Lord's faction to Plot Neutral
    ChangeFaction(oWL, oMarker);
    // Signal Witch Lord to run his exit event
    SignalEvent(oDirector, EventUserDefined(DLA_EVENT_BARROWEXIT_WL));
    AddJournalQuestEntry("MainPlot", 103, oPC, TRUE); //Update the journal
    AddJournalQuestEntry("QRing",     43, oPC, TRUE);     //Update the journal
}

// void main(){}
