//:://////////////////////////////////////////////////
//:: c4_hb_town
/*
  Default OnHeartbeat script for town NPCs.

  This script causes NPCs to perform default animations
  while not otherwise engaged.

  This script duplicates the behavior of the default
  script and just cleans up the code and removes
  redundant conditional checks.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

//#include "in_g_waypoints"
#include "nw_i0_generic"

void main()
{
    // * if not runnning normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW)
        {
        //ActionDoCommand(SpeakString("AI upped" ));
        //SetAILevel(OBJECT_SELF,AI_LEVEL_LOW);
        if (!GetLocalInt(OBJECT_SELF, "DontWalkWaypoints"))
        {
           if (GetLocalInt(OBJECT_SELF,"daytime")==1)
               {
                  //if (GetTimeHour()<8 || (GetTimeHour()>20))
                  if (GetIsNight())
                  {
                     SetLocalInt(OBJECT_SELF,"daytime",0);
                     SetLocalInt(OBJECT_SELF,"nighttime",1);
                     string sTag = "WN_" + GetTag(OBJECT_SELF) + "_";
                     AssignCommand(OBJECT_SELF,ClearAllActions());
                     SetLocalInt(OBJECT_SELF,"iNextWP",1);
                     SetLocalString(OBJECT_SELF,"sPrefixWP",sTag);
                  }
               }
           else
               {
                  if (GetIsDay())
                  {
                     SetLocalInt(OBJECT_SELF,"daytime",1);
                     SetLocalInt(OBJECT_SELF,"nighttime",0);
                     string sTag = "WP_" + GetTag(OBJECT_SELF) + "_";
                     AssignCommand(OBJECT_SELF,ClearAllActions());
                     SetLocalInt(OBJECT_SELF,"iNextWP",1);
                     SetLocalString(OBJECT_SELF,"sPrefixWP",sTag);
                  }
               }
        WalkWayPoints(FALSE,0.2);
        }
        return;
        }

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


    if(GetHasEffect(EFFECT_TYPE_SLEEP))
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
    //else if ( GetWalkCondition(NW_WALK_FLAG_CONSTANT) && !GetLocalInt(OBJECT_SELF, "DontWalkWaypoints") )
      else if (!GetLocalInt(OBJECT_SELF, "DontWalkWaypoints"))
    {
           if (GetLocalInt(OBJECT_SELF,"daytime")==1)
               {
                  //if (GetTimeHour()<8 || (GetTimeHour()>20))
                  if (GetIsNight())
                  {
                     SetLocalInt(OBJECT_SELF,"daytime",0);
                     SetLocalInt(OBJECT_SELF,"nighttime",1);
                     string sTag = "WN_" + GetTag(OBJECT_SELF) + "_";
                     AssignCommand(OBJECT_SELF,ClearAllActions());
                     SetLocalInt(OBJECT_SELF,"iNextWP",1);
                     SetLocalString(OBJECT_SELF,"sPrefixWP",sTag);
                  }
               }
           else
               {
                  if (GetIsDay())
                  {
                     SetLocalInt(OBJECT_SELF,"daytime",1);
                     SetLocalInt(OBJECT_SELF,"nighttime",0);
                     string sTag = "WP_" + GetTag(OBJECT_SELF) + "_";
                     AssignCommand(OBJECT_SELF,ClearAllActions());
                     SetLocalInt(OBJECT_SELF,"iNextWP",1);
                     SetLocalString(OBJECT_SELF,"sPrefixWP",sTag);
                  }
               }
         WalkWayPoints(FALSE,0.2);
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
