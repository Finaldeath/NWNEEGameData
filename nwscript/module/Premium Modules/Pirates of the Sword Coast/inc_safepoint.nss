//::///////////////////////////////////////////////
//:: inc_safepoint
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for the PC safe respawn system
    Developed for PotSC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "_inc_generic"
#include "inc_undead"

const string sSpwnLoc = "PoTSC_SAFELOCATION";
const string sSpwnIdx = "PoTSC_SPAWNINDEX";
const string sSpwnWP = "PoTSC_SPAWNPOINT";

// Resore Hitpoints and facilitate healing
void RestoreHP(object oTarget);

// Remove any negative effects
void SSRemoveEffects(object oTarget);

// Resurrect the Player
void ResurrectPlayer(object oTarget);

// Check the PC for a valid state then start healing process
void ReviveTarget(object oTarget);

// Move to the best spawn location
void MoveToSafeLoc(object oPlayer);

// Call to return player to life
void SpawnPlayer(object oPlayer);

// Update the safe location spawn point
void SetSafeLocation(location lSpwnPnt);

// Check for a safe location spawn point of a higher index in oArea
void UpdateSafePoint(object oArea = OBJECT_SELF);

// Debug Handler
void Debug(string sMSG);

// Check for a safe location spawn point of a higher index in oArea
void UpdateSafePoint(object oArea)
{
    object oModule = GetModule();
    object oCursor = GetFirstObjectInArea(oArea);

    location lSpwnPnt;
    int iIndex = GetLocalInt(oModule, sSpwnIdx);
    int iCurIndex = 0;

    while(GetIsObjectValid(oCursor) == TRUE)
    {
        if (GetTag(oCursor) == sSpwnWP)
        {
            iCurIndex = GetLocalInt(oCursor, sSpwnIdx);

            //Debug("Found new PoTSC_SPAWNPOINT = " + IntToString(iCurIndex));

            if (iCurIndex > iIndex)
            {
                //Debug("Saving new PoTSC_SPAWNPOINT");

                SetLocalInt(oModule, sSpwnIdx, iCurIndex);
                lSpwnPnt = GetLocation(oCursor);
                SetSafeLocation(lSpwnPnt);
            }
        }
        oCursor = GetNextObjectInArea(oArea);
    }
}

// Update the safe location spawn point
void SetSafeLocation(location lSpwnPnt)
{
    //Debug("SetSafeLocation - Set");

    object oModule = GetModule();
    SetLocalLocation(oModule, sSpwnLoc, lSpwnPnt);
}

// Call to return player to life
void SpawnPlayer(object oPlayer)
{
    MoveToSafeLoc(oPlayer);
    ReviveTarget(oPlayer);
}

// Move to the best spawn location
void MoveToSafeLoc(object oPlayer)
{
    object oModule = GetModule();
    object oHench = OBJECT_INVALID;

    location lSpwnPnt = GetLocalLocation(oModule, sSpwnLoc);
    int iCursor = 1;

    // Move the Player
    AssignCommand(oPlayer, ClearAllActions(TRUE));
    JumpPCsToLocation(lSpwnPnt, 0, oPlayer);

    //Debug("MoveToSafeLoc Player - " + GetName(oPlayer));

    // Move his henchmen
    oHench = GetHenchman(oPlayer, iCursor++);
    while(GetIsObjectValid(oHench) == TRUE)
    {
        //Debug("MoveToSafeLoc Henchmen - " + GetName(oHench));
        AssignCommand(oHench, ClearAllActions(TRUE));
        AssignCommand(oHench, JumpToLocation(lSpwnPnt));
        oHench = GetHenchman(oPlayer, iCursor++);
    }
}

// Check the PC for a valid state then start healing process
void ReviveTarget(object oTarget)
{
    float fDelay = 1.0f;

    if (GetIsObjectValid(oTarget) == TRUE)
    {
        //Debug("Object Valid, ResurrectPlayer & RestoreHP called on '" +GetName(oTarget)+ "'");
        ResurrectPlayer(oTarget);
        SSRemoveEffects(oTarget);
        RestoreHP(oTarget);
    }
    else
    {
        //Debug("Object Not Valid, retry in '" +FloatToString(fDelay)+ "' seconds.");
        DelayCommand(1.0f, ReviveTarget(oTarget));
    }
}

// Resurrect the Player
void ResurrectPlayer(object oTarget)
{
    effect eRez = EffectResurrection();
    int iUndead = GetLocalInt(oTarget, "IOP_CUST_UNDEAD");

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRez, oTarget);

    // the the object that rez'd
    if (iUndead == TRUE)
    {
        ApplyVFXEyes(oTarget);
    }
}

//remove any negative effects
void SSRemoveEffects(object oTarget)
{
    effect eBad = GetFirstEffect(oTarget);

    // note: pulled from default death scripts
    while(GetIsEffectValid(eBad))
    {
        int nEffectType = GetEffectType(eBad);
        if (nEffectType == EFFECT_TYPE_ABILITY_DECREASE ||
            nEffectType == EFFECT_TYPE_AC_DECREASE ||
            nEffectType == EFFECT_TYPE_ARCANE_SPELL_FAILURE ||
            nEffectType == EFFECT_TYPE_ATTACK_DECREASE ||
            nEffectType == EFFECT_TYPE_BLINDNESS ||
            nEffectType == EFFECT_TYPE_CHARMED ||
            nEffectType == EFFECT_TYPE_CONFUSED ||
            nEffectType == EFFECT_TYPE_CURSE ||
            nEffectType == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            nEffectType == EFFECT_TYPE_DAMAGE_DECREASE ||
            nEffectType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            nEffectType == EFFECT_TYPE_DAZED ||
            nEffectType == EFFECT_TYPE_DEAF ||
            nEffectType == EFFECT_TYPE_DISEASE ||
            nEffectType == EFFECT_TYPE_DOMINATED ||
            nEffectType == EFFECT_TYPE_ENTANGLE ||
            nEffectType == EFFECT_TYPE_FRIGHTENED ||
            nEffectType == EFFECT_TYPE_NEGATIVELEVEL ||
            nEffectType == EFFECT_TYPE_PARALYZE ||
            nEffectType == EFFECT_TYPE_PETRIFY ||
            nEffectType == EFFECT_TYPE_POISON ||
            nEffectType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            nEffectType == EFFECT_TYPE_SILENCE ||
            nEffectType == EFFECT_TYPE_SKILL_DECREASE ||
            nEffectType == EFFECT_TYPE_SLEEP ||
            nEffectType == EFFECT_TYPE_SLOW ||
            nEffectType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            nEffectType == EFFECT_TYPE_STUNNED)
        {
                //Remove effect if it is negative.
                DelayCommand(0.1f, RemoveEffect(oTarget, eBad));
            }

        eBad = GetNextEffect(oTarget);
    }

    return;
}

// Resore Hitpoints and facilitate healing
void RestoreHP(object oTarget)
{
    effect eHeal;
    int iTotalHP = GetMaxHitPoints(oTarget);
    int iCurrentHP = GetCurrentHitPoints(oTarget);
    int iHeal;
    float fPercent;

    // Scale healing based on game difficulty.
    switch (GetGameDifficulty())
    {
        case GAME_DIFFICULTY_CORE_RULES :
        case GAME_DIFFICULTY_DIFFICULT :
            fPercent = 0.1f;
        break;

        case GAME_DIFFICULTY_NORMAL :
            fPercent = 0.5f;
        break;

        case GAME_DIFFICULTY_EASY :
        case GAME_DIFFICULTY_VERY_EASY :
        default:
            fPercent = 0.75f;
        break;
    }

    // Create Value based on a precentage
    iHeal = FloatToInt(IntToFloat(iTotalHP - iCurrentHP) * fPercent);

    //Debug("RestoreHP: iTotalHP '" + IntToString(iTotalHP)
    //    + "'; iCurrentHP '" + IntToString(iCurrentHP)
    //    + "'; fPercent '" + FloatToString(fPercent)
    //    + "'; iHeal = " + IntToString(iHeal));

    // Make sure the player gets more then 0 HP and no more then 100% HP
    if (iCurrentHP + iHeal <= 0)
        iHeal = abs((iCurrentHP + 1));
    else if((iHeal + iCurrentHP) > iTotalHP)
        iHeal = iTotalHP - iCurrentHP;

    //Debug("RestoreHP Adjusted - '" + GetName(oTarget) + "'; iHeal = " + IntToString(iHeal));

    eHeal = EffectHeal(iHeal);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
}

// Debug Message Handler
void Debug(string sMSG)
{
    object oCursor = GetFirstPC();
    while (GetIsObjectValid(oCursor))
    {
        //SendMessageToPC(oCursor, sMSG);
        oCursor = GetNextPC();
    }
}
