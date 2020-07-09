/*
This script will cause an NPC to head for a nearby exit object.
When the exit is reached, the NPC will destroy himself.

OBJECT:
 - HF_EXIT_NAME
    The tag of the destination object to walk to.
    The default = WP_EXIT_<tag>
 - HF_EXIT_MAX_DELAY
    Destroy yourself after this many seconds (fail safe).
    The default = 15.
 - HF_EXIT_RUN
    Set to 1 and the NPC will run to the destination.
    The default is no running.
 - HF_EXIT_SCRIPT
    The name of a script to execute when you arrive at the destination.
    The default is just destroy yourself.
 - HF_EXIT_CHAIN
    If set to 1, the NPC will attempt to walk a route marked by
    destination objects with names ending in "_01", "_02", etc.
*/

#include "nw_i0_generic"
#include "x0_i0_walkway"

// init the timer
void TimerInit(object o)
{
    if (GetIsObjectValid(o))
    {
        int nTimer = GetLocalInt(o, "HF_EXIT_MAX_DELAY");
        if (nTimer <= 0)
            nTimer = 30;
        SetLocalInt(o, "HF_EXIT_TIMER_VALUE", nTimer);
    }
}

// check if the timer has expired
int TimerIsExpired(object o)
{
    if (GetIsObjectValid(o))
    {
        int nTimer = GetLocalInt(o, "HF_EXIT_TIMER_VALUE");
        return(nTimer <= 0);
    }
    return(TRUE);
}

// decrement the timer
void TimerDecrement(object o)
{
    if (GetIsObjectValid(o))
    {
        int nTimer = GetLocalInt(o, "HF_EXIT_TIMER_VALUE");
        SetLocalInt(o, "HF_EXIT_TIMER_VALUE", --nTimer);
    }
}

// can this NPC move?
int IsAbleToMove(object o)
{
   if (GetHasEffect(EFFECT_TYPE_CONFUSED, o) ||
       GetHasEffect(EFFECT_TYPE_DOMINATED, o)||
       GetHasEffect(EFFECT_TYPE_PETRIFY, o)  ||
       GetHasEffect(EFFECT_TYPE_PARALYZE, o) ||
       GetHasEffect(EFFECT_TYPE_STUNNED, o)  ||
       GetHasEffect(EFFECT_TYPE_SLEEP, o)    ||
       GetIsDead(o))
    {
        return FALSE;
    }
   return TRUE;
}

// we have arrived at the destination; perform our exit action
// .. nReason = -1 if the destination was invalid
// .. nReason =  0 if the timer expired before destination reached
// .. nReason =  1 if the destination was reached
void ExitAction(object o, int nReason)
{
    // if we are walking a chain try to go for the next node
    int nPos = GetLocalInt(o, "HF_EXIT_CHAIN");
    if (nPos != 0)
    {
        if (nReason >= 1)
        {
            // we reached the last destination so keep going
            SetLocalInt(o, "HF_EXIT_CHAIN", ++nPos);
            ExecuteScript("hf_cs_exit", o);
            return;
        }
    }

    // do the final exit action
    string sScript = GetLocalString(o, "HF_EXIT_SCRIPT");
    if (sScript != "")
    {
        SetLocalInt(o, "HF_EXIT_REASON", nReason);
        ExecuteScript(sScript, o);
    }
    else
    {
        DestroyObject(o);
    }
}

void main()
{
    // do nothing if we are unable to move
    if (!IsAbleToMove(OBJECT_SELF) ||
         IsInConversation(OBJECT_SELF) ||
         GetIsInCombat(OBJECT_SELF))
    {
        DelayCommand(1.0, ExecuteScript("hf_cs_exit", OBJECT_SELF));
        return;
    }

    // init the time-to-live timer and stop doing ambient actions
    if (GetLocalInt(OBJECT_SELF, "HF_EXIT_STARTED") == 0)
    {
        SetLocalInt(OBJECT_SELF, "HF_EXIT_STARTED", 1);
        TimerInit(OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "HF_DISABLE_AM", 1);
    }

    // check the timer
    if (TimerIsExpired(OBJECT_SELF))
    {
        ExitAction(OBJECT_SELF, 0);
        return;
    }

    // in case we are waypoint walking, stop doing that
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);

    // make sure we can be destroyed eventually
    SetIsDestroyable(TRUE);

    // find our current exit destination's tag
    string sDest = GetLocalString(OBJECT_SELF, "HF_EXIT_NAME");
    if (sDest == "")
        sDest = "WP_EXIT_" + GetTag(OBJECT_SELF);
    int nPos = GetLocalInt(OBJECT_SELF, "HF_EXIT_CHAIN");
    if (nPos != 0)
    {
        if (nPos <= 9)
            sDest = sDest + "_0" + IntToString(nPos);
        else
            sDest = sDest + "_" +  IntToString(nPos);
    }

    // locate the destination object
    object oDest = GetNearestObjectByTag(sDest, OBJECT_SELF);
    if (GetIsObjectValid(oDest))
    {
        float fDist = GetDistanceBetween(OBJECT_SELF, oDest);
        if (fDist <= 1.0)
        {
            // we've arrived so vanish
            ExitAction(OBJECT_SELF, 1);
        }
        else
        {
            // walk towards destination
            int nRun = GetLocalInt(OBJECT_SELF, "HF_EXIT_RUN");
            TimerDecrement(OBJECT_SELF);
            ClearAllActions();
            ActionMoveToObject(oDest, nRun, 0.0);
            DelayCommand(1.0, ExecuteScript("hf_cs_exit", OBJECT_SELF));
        }
    }
    else
    {
        // we couldn't find our exit destination so just exit
        ExitAction(OBJECT_SELF, -1);
    }
}


