//:://////////////////////////////////////////////////
//:: nhb_tm_tharzhent
// Heartbeat script for Zhents in Iyrauroth's Domain
// Will follow PC when in Iyauroth's Lair

#include "nw_i0_generic"

#include "hf_in_plot"

void main()
{
    // * if not runnning normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

   // Buff ourselves up right away if we should
    if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
    {
        // This will return TRUE if an enemy was within 40.0 m
        // and we buffed ourselves up instantly to respond --
        // simulates a spellcaster with protections enabled
        // already.
        if(TalentAdvancedBuff(40.0))
        {
            // This is a one-shot deal
            SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);

            // This return means we skip sending the user-defined
            // heartbeat signal in this one case.
            return;
        }
    }

    //If Dominion has been found and PC leaves area, destroy assassins
    if(PlotLevelGet(GetTag(OBJECT_SELF)) > 5 &&
       GetTag(GetArea(GetFirstPC())) != "karstrongholdupper")
    {
        DestroyObject(OBJECT_SELF, 1.0);
        return;
    }

    if(GetIsDead(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF) ||
       IsInConversation(OBJECT_SELF))
    {
        return;
    }

    //Pause for initial Maganus cutscene
    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 2)
    {
    }
    //Attack nearest enemy at end of initial Maganus cutscene
    else
    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 3)
    {
        object oEnemy = GetNearestPerceivedEnemy();
        if(oEnemy != OBJECT_INVALID)
        {
            DetermineCombatRound(GetNearestPerceivedEnemy());
        }
        else
        {
            ActionMoveToObject(GetNearestObjectByTag("StrongholdMaganus"));
        }
    }
    //Watching Maganus/Orcus cutscene
    else
    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 4)
    {
    }
    //Maganus and Orcus have departed, now we want to find Dominion
    else
    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 5)
    {
        int nRand = d6();

        ClearAllActions();

        if(nRand < 4)
        {
            string sWP = "WP_KTUF_SHAD_RANDOM" + IntToString(d4());
            ActionMoveToLocation(GetLocation(GetWaypointByTag(sWP)));
        }
        else
        if(nRand == 4)
        {
            ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 4.0);
        }
        else
        if(nRand == 5)
        {
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0);
        }
        else
        if(nRand == 6)
        {
            ActionRandomWalk();
        }
    }
    //Dominion has been found, initiate dialog and gather around PC
    else
    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 6)
    {
        object oPC = GetFirstPC();

        ClearAllActions();

        if(GetLocalInt(OBJECT_SELF, "nForceDialog") == 1)
        {
            ActionStartConversation(oPC, "", FALSE, FALSE);
        }
        else
        {
            ActionMoveToObject(oPC, TRUE, 3.0);
        }
    }
    //Following PC around Kur-Tharsu upper floor
    else
    if(PlotLevelGet(GetTag(OBJECT_SELF)) == 1)
    {
        object oPC = GetFirstPC();

        float nDistance = GetDistanceBetween(OBJECT_SELF, oPC);
        //If PC not in KT Upper Floor, jump to home location
        if(GetTag(GetArea(oPC)) != "karstrongholdupper")
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(4710));
        }
        //Jump to PC if far away in same area
        else
        if(nDistance > 25.0)
        {
            ClearAllActions(TRUE);
            JumpToObject(oPC);
        }
        //Default heartbeat action to follow PC
        else
        {
            if(nDistance > 0.0 && nDistance < 3.0 &&
              !GetIsInCombat(OBJECT_SELF) && !IsInConversation(OBJECT_SELF) &&
              !GetIsDead(OBJECT_SELF))
            {
                effect eGhost = EffectCutsceneGhost();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost,
                                    OBJECT_SELF, RoundsToSeconds(1));
            }

            int nRoll = d10();
            if(nRoll == 1)
            {
                ClearAllActions();
                int nRoll2 = d10();

                if(nRoll2 == 1)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 4.0);
                }
                else if (nRoll2 == 2 || nRoll2 == 3)
                {
                    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0);
                }
                else if (nRoll2 == 4 || nRoll2 == 5)
                {
                    effect eStealth = EffectVisualEffect(VFX_DUR_INVISIBILITY);
                    SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStealth, OBJECT_SELF, RoundsToSeconds(3));
                    DelayCommand(RoundsToSeconds(3),
                        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE));
                }
                else
                {
                    ActionRandomWalk();
                    DelayCommand(RoundsToSeconds(1), ClearAllActions());
                }
            }
            else
            {
                if(GetCurrentAction() != ACTION_FOLLOW)
                {
                    ActionForceFollowObject(oPC, GetLocalFloat(OBJECT_SELF, "FOLLOW_DISTANCE"));
                }
            }
        }
    }
    else if(GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        // If we're asleep and this is the result of sleeping
        // at night, apply the floating 'z's visual effect
        // every so often

        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            if(d10() > 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            }
        }
    }

    // If we have the 'constant' waypoints flag set, walk to the next
    // waypoint.
    else if ( GetWalkCondition(NW_WALK_FLAG_CONSTANT) )
    {
        WalkWayPoints();
    }

    // Check to see if we should be playing default animations
    // - make sure we don't have any current targets
    else if ( !GetIsObjectValid(GetAttemptedAttackTarget())
          && !GetIsObjectValid(GetAttemptedSpellTarget())
          // && !GetIsPostOrWalking())
          && !GetIsObjectValid(GetNearestSeenEnemy()))
    {
        if (GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) || GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE) ||
            GetBehaviorState(NW_FLAG_BEHAVIOR_HERBIVORE))
        {
            // This handles special attacking/fleeing behavior
            // for omnivores & herbivores.
            DetermineSpecialBehavior();
        }
        else if (!IsInConversation(OBJECT_SELF))
        {
            if (GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
                || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
                || GetIsEncounterCreature())
            {
                PlayMobileAmbientAnimations();
            }
            else if (GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS))
            {
                PlayImmobileAmbientAnimations();
            }
        }
    }

    // Send the user-defined event signal if specified
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_HEARTBEAT));
    }
}

