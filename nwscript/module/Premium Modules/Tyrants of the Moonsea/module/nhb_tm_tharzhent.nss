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

    if(PlotLevelGet("ZhentsFollowing") == 1 && !GetIsDead(OBJECT_SELF) &&
       !GetIsInCombat(OBJECT_SELF))
    {
        int nRoll = d10();

        object oPC = GetFirstPC();

        if(nRoll == 1)
        {
            ClearAllActions();
            int nRoll2 = d6();

            if(nRoll2 == 1)
            {
                ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 4.0);
            }
            else
            if(nRoll2 == 2 && GetLevelByClass(CLASS_TYPE_CLERIC) > 0)
            {
                ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 4.0);
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
                ActionForceFollowObject(oPC,
                                        GetLocalFloat(OBJECT_SELF, "FOLLOW_DISTANCE"));
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

