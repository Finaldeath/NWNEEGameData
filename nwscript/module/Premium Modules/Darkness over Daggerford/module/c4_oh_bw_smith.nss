//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT1
/*
  Default OnHeartbeat script for NPCs.

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

#include "nw_i0_generic"

void main()
{
    object oWorkItem = GetLocalObject(OBJECT_SELF, "oWorkItem");
    if (GetIsObjectValid(oWorkItem))
    {
        return;
    }

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
    else if ( GetWalkCondition(NW_WALK_FLAG_CONSTANT) )
    {
        WalkWayPoints();
    }

    // duke is injured, lay down unless doing something else
    if ((GetLocalInt(OBJECT_SELF, "iWorking") == 0) &&
        !GetIsInCombat() && (!IsInConversation(OBJECT_SELF)))
    {
        int nAction = GetCurrentAction();
        if ((nAction != ACTION_ATTACKOBJECT) &&
            (nAction != ACTION_MOVETOPOINT))
        {
            int nAction = d4();
            object oWP;

            if (nAction == 4)
            {
                oWP = GetNearestObjectByTag("bw_smith_walk2");
                ActionMoveToObject(oWP);
                ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.2);
            }
            else
            {
                oWP = GetNearestObjectByTag("bw_smith_walk1");
                ActionMoveToObject(oWP);
                object oAnvil = GetNearestObjectByTag("bw_smith_anvil");
                ActionAttack(oAnvil);
            }
        }
    }

    // Send the user-defined event signal if specified
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_HEARTBEAT));
    }
}

