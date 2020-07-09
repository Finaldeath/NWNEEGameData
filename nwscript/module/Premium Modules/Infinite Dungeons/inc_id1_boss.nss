//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_boss
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    General include file for the boss fights of Infinite Dungeons. Contains
    constants and functions usefull across all the fights.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 20, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_score"



// DEBUG
// void main() {}



/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Boss Tags.
const string GZHORB_TAG = "id1_gzhorb";
const string HALASTER_TAG = "id1_halaster";
const string HARAT_TAG = "id1_harat";
const string ANTOINE_TAG = "id1_antoine";
const string MAGGRIS_TAG = "id1_maggris";
const string MASTERIUS_TAG = "id1_masterius";
const string HAGATHA_TAG = "id1_hagatha";

// Placeable tags.
const string BOSS_DOOR_TAG = "ID1_STATIC_DOOR";
const string BOSS_LOOT_STORAGE = "ID1_BOSS_INVENTORY";

// Universal Creature Tags and ResRefs.
const string MINION_TAG = "id1_minion"; // Boss minion creatures.
const string NUETRAL_RESREF = "id1_nuetral"; // Nuetral NPC for faction changes.
const string HOSTILE_RESREF = "id1_hostile"; // Hostile NPC for faction changes.
const string BOSS_LOOT_RESREF = "id1_bossinv"; // Loot storage object.

// Variable name constants.
const string PERCEIVED_ONCE = "bPerceived";
const string SURRENDER_FLAG = "bSurrender";
const string CONVERSATION_STATUS = "nConversation";
const string RECENTLY_CREATED = "oStoredObject";
const string BOSS_GENERATED = "bBossGenerated";
const string BOSS_ACTIVATED = "bBossActivated";

// Conversation status variables.
const int CON_GIVE_QUEST = 20;
const int CON_QUEST_ACCEPTED = 30;
const int CON_QUEST_REFUSED = 40;
const int CON_QUEST_COMPLETED = 50;



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Shake Screen
//
// Defined in: inc_id1_boss
//
// Applies a screen shaking effect to each of the players participating in a
// module.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ShakeScreen();

// Name: Apply Effect To All Players
//
// Defined in: inc_id1_boss
//
// Applys an effect to all players presesnt in the module.
//
// Parameters:
// eEffect - The effect to be applied to the players.
// nDurationType - The duration type to use when applying the effect.
//
// Return:
//
void ApplyEffectToAllPlayers(effect eEffect, int nDurationType, float fDuration = 0.0);

// Name: Boss Surrender
//
// Defined in: inc_id1_boss
//
// Function for having a boss creature surrender to the player. this function
// will destroy all of the bosses' minions and then set the boss to a nuetral
// faction and make them plot to avoid faction problems.
//
// NOTE: Alot of the surrender code is based on the surrender system from x0
// by Naomi Novik. See 'x0_ud_surr_*'.
//
// Parameters:
// oBoss - The boss doing the surrendering.
//
// Return:
// NONE
void BossSurrender(object oBoss = OBJECT_SELF);

// Name: Remove All Effects
//
// Defined in: inc_id1_boss
//
// Removes all effects of type nEffectType from oTarget. If nEffectType is not
// specified All effects will be removed.
//
// Parameters:
// oTarget - The object from which the effects should be removed.
// nEffectType - The type of effect to be removed. One of the EFFECT_TYPE_*
//               constants.
//
// Return:
// NONE
void RemoveAllEffects(object oTarget, int nEffectType = EFFECT_TYPE_INVALIDEFFECT);

// Name: Lock Area
//
// Defined in: inc_id1_boss
//
// Locks or unlocks all the doors in a boss lair. This is used to ensure the
// players cannot leave the area while the boss battle is in progress.
//
// Parameters:
// oArea - The area whose exits should be locked or unlocked.
// bUnlock - If this argument is TRUE the doors will be unlocked, otherwise they
//           will be closed and locked.
//
// Return:
// NONE
void LockArea(object oArea = OBJECT_SELF, int bUnlock = FALSE);

// Name: Boss Generate Loot
//
// Defined in: inc_id1_boss
//
// Generates loot for a boss creature and stores it on an invisible object for
// transfer on the bosses death.
//
// Parameters:
// oBoss - The boss creature for who the loot is being generated. Used in order
//         to establish level etc.
//
// Return:
// NONE
void BossGenerateLoot(object oBoss);

// Name: Boss Create Loot
//
// Defined in: inc_id1_boss
//
// Creates some loot on a boss creature by transfering it from the storage
// object.
//
// Parameters:
// NONE
//
// Return:
// NONE
void BossTransferLoot(object oBoss);


/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: ShakeScreen
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void ShakeScreen()
{
    object oPC = GetFirstPC();
    effect eVFX = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

    while (GetIsObjectValid(oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);

        oPC = GetNextPC();
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: ApplyEffectToAllPlayers
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void ApplyEffectToAllPlayers(effect eEffect, int nDurationType, float fDuration = 0.0)
{
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        ApplyEffectToObject(nDurationType, eEffect, oPC, fDuration);

        oPC = GetNextPC();
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: BossSurrender
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 22, 2005
//::////////////////////////////////////////////////////////////////////////////
void BossSurrender(object oBoss = OBJECT_SELF)
{
    // Clear out any actions left from the fight.
    while (!GetCommandable(oBoss))
    {
        SetCommandable(TRUE, oBoss);
    }

    AssignCommand(oBoss, ClearAllActions(TRUE));

    // To avoid having a stray fireball set the boss hostile again set plot.
    SetPlotFlag(oBoss, TRUE);
    SetLocalInt(oBoss, "bBoss", TRUE); // For the score system's reference.

    // Force the boss to surrender and change his faction.
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));

        ClearPersonalReputation(oPC, oBoss);
        ClearPersonalReputation(oBoss, oPC);

        // April 4, 2005 award the player points for defeating a boss.
        AwardCreatureKilledPoints(oPC);

        oPC = GetNextPC();
    } // end while

    // change to neutral
    ChangeFaction(oBoss, DB_GetObjectByTag("DungeonAngel"));

    // Flag the boss as surrendered on the module.
    string sTag = GetTag(oBoss);

    if (sTag == ANTOINE_TAG)
    {
        SetLocalInt(GetModule(), "bBacchaSurrender", TRUE);
    }
    else if (sTag == HAGATHA_TAG)
    {
        SetLocalInt(GetModule(), "bHagathaSurrender", TRUE);
    }
    else if (sTag == MAGGRIS_TAG)
    {
        SetLocalInt(GetModule(), "bMaggrisSurrender", TRUE);
    }
    else if (sTag == HARAT_TAG)
    {
        SetLocalInt(GetModule(), "bHaratSurrender", TRUE);
    }
    else if (sTag == GZHORB_TAG)
    {
        SetLocalInt(GetModule(), "bGzhorbSurrender", TRUE);

        // Special case handling to shut off G'Zhorb's beholder ai.
        DeleteLocalInt(oBoss, "X2_L_BEH_MAGIC");
        DeleteLocalString(oBoss, "X2_SPECIAL_COMBAT_AI_SCRIPT");
    }
    else if (sTag == MASTERIUS_TAG)
    {
        SetLocalInt(GetModule(), "bMasteriusSurrender", TRUE);
    }
    else if (sTag == HALASTER_TAG)
    {
        SetLocalInt(GetModule(), "bHalasterSurrender", TRUE);
    }

    // Notify the boss that he has surrendered for dialog conditionals.
    // SetLocalInt(oBoss, SURRENDER_FLAG, TRUE);

    // Explicit handling for Antoine's extra minions.
    SetLocalInt(oBoss, "nMinionsKilled", 1000);

    // Kill off all of the bosses' minions.
    int nNth = 1;
    object oMinion = GetNearestObjectByTag(MINION_TAG, oBoss, nNth);
    effect eDeath = EffectDeath();
    effect eDamage = EffectDamage(1000);

    while (GetIsObjectValid(oMinion))
    {
        // Assign the module to kill the minion to avoid faction problems.
        AssignCommand(GetModule(),
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oMinion));

        nNth++;

        oMinion = GetNearestObjectByTag(MINION_TAG, oBoss, nNth);
    } // end while

    // Kill off any summoned creatures.
    nNth = 1;
    object oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oBoss, nNth);

    while (GetIsObjectValid(oAssociate))
    {
        AssignCommand(GetModule(),
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oAssociate));

        nNth++;

        oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oBoss, nNth);
    }

    // And any possible familiars.
    nNth = 1;
    oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oBoss, nNth);

    while (GetIsObjectValid(oAssociate))
    {
        AssignCommand(GetModule(),
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oAssociate));

        nNth++;

        oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oBoss, nNth);
    }

    // Make the boss and the players like one another.
    AssignCommand(oBoss, SurrenderToEnemies());

    // Unlock the area.
    object oArea = GetArea(oBoss);

    LockArea(oArea, TRUE);

    // Destroy all AOE objects in the area.
    object oAOE = GetFirstObjectInArea(oArea);
    int nType;

    while(GetIsObjectValid(oAOE))
    {
        nType = GetObjectType(oAOE);

        if(nType == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            DestroyObject(oAOE, 0.2);
        }

        oAOE = GetNextObjectInArea(oArea);
    }

    // Start the surrender conversation.
    SpeakOneLinerConversation();
}

//::////////////////////////////////////////////////////////////////////////////
//:: RemoveAllEffects
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void RemoveAllEffects(object oTarget, int nEffectType = EFFECT_TYPE_INVALIDEFFECT)
{
    effect eRemove = GetFirstEffect(oTarget);
    int nType = GetEffectType(eRemove);

    // Cycle all the effects active on the target.
    while (nType != EFFECT_TYPE_INVALIDEFFECT)
    {
        // If the default effect type parameter or the parameter matches the type.
        if (nEffectType == EFFECT_TYPE_INVALIDEFFECT || nEffectType == nType)
        {
            RemoveEffect(oTarget, eRemove);
        }

        eRemove = GetNextEffect(oTarget);
        nType = GetEffectType(eRemove);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: LockArea
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 06, 2006
//::////////////////////////////////////////////////////////////////////////////
void LockArea(object oArea = OBJECT_SELF, int bUnlock = FALSE)
{
    int nNth = 1;
    object oTarget = GetFirstObjectInArea(oArea); // Starting point to find doors.

    object oDoor = DB_GetNearestObjectByTag(BOSS_DOOR_TAG, oTarget, nNth);

    // Loop all doors near to oTarget.
    while(GetIsObjectValid(oDoor))
    {
        if (bUnlock) // Unlock the area.
        {
            AssignCommand(oDoor, ActionUnlockObject(oDoor));
        }
        else // Lock the area.
        {
            AssignCommand(oDoor, ActionCloseDoor(oDoor));
            AssignCommand(oDoor, ActionLockObject(oDoor));
        }

        nNth++;

        oDoor = DB_GetNearestObjectByTag(BOSS_DOOR_TAG, oTarget, nNth);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: BossGenerateLoot
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 27, 2006
//::////////////////////////////////////////////////////////////////////////////
void BossGenerateLoot(object oBoss)
{
    // Establish the storage object and the loot level based on the boss.
    object oWaypoint = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", oBoss);
    if (oWaypoint != OBJECT_INVALID)
    {
        location lLoc = GetLocation(oWaypoint);
        object oStore = DB_CreateObject(OBJECT_TYPE_PLACEABLE, BOSS_LOOT_RESREF, lLoc);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oStore);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oStore);
        SetPlotFlag(oStore, TRUE);

        int nLevel = GetLocalInt(oBoss, "nCR");

        object oMicroCPU;
        int i;

        // Create 5 items.
        for (i = 1; i < 6; ++i)
        {
            oMicroCPU = DB_CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU105");
            SetLocalInt(oMicroCPU, "nLevel", nLevel);
            SetLocalObject(oMicroCPU, "oStore", oStore);
            DelayCommand(0.01, ExecuteScript("exe_id1_micstrit", oMicroCPU));
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: BossTransferLoot
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: March 27, 2006
//::////////////////////////////////////////////////////////////////////////////
void BossTransferLoot(object oBoss)
{
    object oStore = DB_GetObjectByTag(BOSS_LOOT_STORAGE);
    object oItem = GetFirstItemInInventory(oStore);

    // Copy over all the items in the store's inventory to the boss.
    while (GetIsObjectValid(oItem))
    {
        CopyItem(oItem, oBoss);

        DestroyObject(oItem, 1.0);

        oItem = GetNextItemInInventory(oStore);
    }

    // Create some gold.
    int nLevel = GetLocalInt(oBoss, "nCR");

    GiveGoldToCreature(oBoss, (Random(50) + 50) * nLevel);

    DestroyObject(oStore, 5.0);
}

//void main() {}

