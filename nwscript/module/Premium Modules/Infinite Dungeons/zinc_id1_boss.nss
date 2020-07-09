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



#include "inc_id1_debug"
#include "inc_id1_utility"



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

// Universal Creature Tags and ResRefs.
const string MINION_TAG = "id1_minion"; // Boss minion creatures.
const string NUETRAL_RESREF = "id1_nuetral"; // Nuetral NPC for faction changes.
const string HOSTILE_RESREF = "id1_hostile"; // Hostile NPC for faction changes.

// Variable name constants.
const string PERCEIVED_ONCE = "bPerceived";
const string SURRENDER_FLAG = "bSurrender";
const string CONVERSATION_STATUS = "nConversation";
const string RECENTLY_CREATED = "oStoredObject";

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

// Name: Get Party Level
//
// Defined in: inc_id1_boss
//
// Returns the average level of all the players in the module.
//
// Parameters:
// NONE
//
// Return:
// The average level of all the players in the module or -1 on error.
//int GetPartyLevel();

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

// Name: Delay Create Object
//
// Defined in: inc_id1_boss
//
// Wrapper function for DB_CreateObject (which is a wrapper function for
// CreateObject) provided in order to create objects on a delay. The object
// created is stored on the module and can be accessed via GetLastObjectCreated.
//
// Parameters:
// See DB_CreateObject in "inc_debug"
//
// Return:
// NONE
void DelayCreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "");

// Name: Get Last Object Created
//
// Defined in: inc_id1_boss
//
// Retreives the last object created with a call to DelayCreateObject. Each call
// to DelayCreateObject over-writes the object reference returned by this
// funciton so it will only return the most recently created object.
//
// Parameters:
// NONE
//
// Return:
// The most recently created object or OBJECT_INVALID (documented via debug
// message) on error.
object GetLastObjectCreated();



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
//:: GetPartyLevel
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Sep 21, 2005
//::////////////////////////////////////////////////////////////////////////////
/*int GetPartyLevel()
{
    object oPC = GetFirstPC();
    int nLevel = 0;
    int nHighestLevel = 0;
    int nPCs = 0;

    // While valid sum the level of the next pc and keep a total.
    while (GetIsObjectValid(oPC))
    {
        nLevel = GetHitDice(oPC);

        if (nLevel > nHighestLevel)
        {
            nHighestLevel = nLevel;
        }

        nPCs++;

        oPC = GetNextPC();
    }

    // If the number of PCs is 0 something has gone wrong.
    if (nPCs == 0)
    {
        DebugMessage("Could not detect any players.");
        return -1; // Avoid division by 0.
    }

    nLevel = nHighestLevel + (nPCs - 1);

    // Return the average.
    return nLevel;
}*/

//::////////////////////////////////////////////////////////////////////////////
//:: BossSurrender
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 22, 2005
//::////////////////////////////////////////////////////////////////////////////
void BossSurrender(object oBoss = OBJECT_SELF)
{
    // First kill off all of the bosses' minions.
    int nNth = 1;
    object oMinion = GetNearestObjectByTag(MINION_TAG, oBoss, nNth);
    effect eDeath = EffectDeath();

    while (GetIsObjectValid(oMinion))
    {
        // Assign the module to kill the minion to avoid faction problems.
        AssignCommand(GetModule(),
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oMinion));

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

        oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oBoss, nNth);
    }

    // Explicit handling for Antoine's extra minions. //////////////////////////
    nNth = 1;
    oMinion = GetNearestObjectByTag("id1_wereboar", oBoss, nNth);

    while (GetIsObjectValid(oMinion))
    {
        // Assign the module to kill the minion to avoid faction problems.
        AssignCommand(GetModule(),
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oMinion));

        nNth++;

        oMinion = GetNearestObjectByTag("id1_wereboar", oBoss, nNth);
    } // end while

    nNth = 1;
    oMinion = GetNearestObjectByTag("wereboar", oBoss, nNth);

    while (GetIsObjectValid(oMinion))
    {
        // Assign the module to kill the minion to avoid faction problems.
        AssignCommand(GetModule(),
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oMinion));

        nNth++;

        oMinion = GetNearestObjectByTag("wereboar", oBoss, nNth);
    } // end while

    ////////////////////////////////////////////////////////////////////////////

    // Clear out any actions left from the fight.
    AssignCommand(oBoss, ClearAllActions(TRUE));

    // To avoid having a stray fireball set the boss hostile again set plot.
    SetPlotFlag(oBoss, TRUE);

    // Make the boss and the players like one another.
    SurrenderToEnemies();

    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));

        ClearPersonalReputation(oPC, oBoss);

        oPC = GetNextPC();
    } // end while

    // change to neutral
    ChangeFaction(oBoss, DB_GetObjectByTag("DungeonAngel"));

    // Notify the boss that he has surrendered for dialog conditionals.
//    SetLocalInt(oBoss, SURRENDER_FLAG, TRUE);

    // detect which boss this is
    string sTag = GetTag(oBoss);
    if (sTag == ANTOINE_TAG)
    {
        SetLocalInt(GetModule(), "bBacchaSurrender", TRUE);
    } else if (sTag == HAGATHA_TAG)
    {
        SetLocalInt(GetModule(), "bHagathaSurrender", TRUE);
    } else if (sTag == MAGGRIS_TAG)
    {
        SetLocalInt(GetModule(), "bMaggrisSurrender", TRUE);
    } else if (sTag == HARAT_TAG)
    {
        SetLocalInt(GetModule(), "bHaratSurrender", TRUE);
    } else if (sTag == GZHORB_TAG)
    {
        SetLocalInt(GetModule(), "bGzhorbSurrender", TRUE);
    } else if (sTag == MASTERIUS_TAG)
    {
        SetLocalInt(GetModule(), "bMasteriusSurrender", TRUE);
    } else if (sTag == HALASTER_TAG)
    {
        SetLocalInt(GetModule(), "bHalasterSurrender", TRUE);
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
//:: DelayCreateObject
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 28, 2005
//::////////////////////////////////////////////////////////////////////////////
void DelayCreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation = FALSE, string sNewTag = "")
{
    object oCreated = DB_CreateObject(nObjectType, sTemplate, lLocation,
        bUseAppearAnimation, sNewTag);

    SetLocalObject(GetModule(), RECENTLY_CREATED, oCreated);
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetLastObjectCreated
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 28, 2005
//::////////////////////////////////////////////////////////////////////////////
object GetLastObjectCreated()
{
    object oRet = GetLocalObject(GetModule(), RECENTLY_CREATED);

    if (!GetIsObjectValid(oRet))
    {
        DebugMessage("inc_id1_boss::GetLastObjectCreated() OBJECT_INVALID");

        return OBJECT_INVALID;
    }

    return oRet;
}

//void main(){}

