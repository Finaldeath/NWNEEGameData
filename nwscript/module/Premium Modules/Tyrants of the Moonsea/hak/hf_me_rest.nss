// this module rest event triggers the nearest rest encounters

#include "hf_in_spawn"
#include "hf_in_henchman"
#include "hf_in_friend"
#include "hf_in_rest"

// ---------------------------------------------------------------------------
// Encounter Functions
// ---------------------------------------------------------------------------

// find a rest encounter in this area that will fire
// start looking at the nearest encounter and keep going until we run out
object RestGetEncounter(object oPC)
{
    int i = 1;
    object oEnc = GetNearestObjectByTag("ENC_Rest", oPC, i);
    while (GetIsObjectValid(oEnc))
    {
        if (SpawnCheckEncounter(oEnc, oPC))
        {
            return(oEnc);
        }
        oEnc = GetNearestObjectByTag("ENC_Rest", oPC, ++i);
    }
    return(OBJECT_INVALID);
}

// it is safe to rest inside certain triggers
// but if the trigger includes doors, they all must be closed
int RestInSafeZone(object oPC)
{
    object oTrigger = GetNearestObjectByTag("HF_REST_SAFE_ZONE", oPC);
    int bAtLeastOneDoor = FALSE;
    int bAllDoorsClosed = TRUE;
    int bPCInTrigger = FALSE;

    if (GetIsObjectValid(oTrigger))
    {
        if (GetObjectType(oTrigger) == OBJECT_TYPE_TRIGGER)
        {
            object o = GetFirstInPersistentObject(oTrigger, OBJECT_TYPE_ALL);
            while (GetIsObjectValid(o))
            {
                if (oPC == o)
                {
                    bPCInTrigger = TRUE;
                }
                else
                {
                    if (GetObjectType(o) == OBJECT_TYPE_DOOR)
                    {
                        bAtLeastOneDoor = TRUE;
                        if (GetIsOpen(o))
                        {
                            return FALSE;
                        }
                    }
                }
                o = GetNextInPersistentObject(oTrigger, OBJECT_TYPE_ALL);
            }
        }
    }
    if (bPCInTrigger == FALSE || bAtLeastOneDoor == FALSE)
    {
        return FALSE;
    }
    return TRUE;
}

// run a rest encounter for this player
void RestEncounter(object oPC, object oEnc)
{
    SpawnEncounter(oEnc, oPC, TRUE);
}

// returns true if resting is allowed in this area
int RestIsPossible(object oPC)
{
    object oArea = GetArea(oPC);
    if (GetLocalInt(oArea, "HF_REST_DISABLED") > 0)
    {
        return FALSE;
    }
    return TRUE;
}

// ---------------------------------------------------------------------------
// Rest Functions
// ---------------------------------------------------------------------------

// handle the actual rest
void Rest(object oPC)
{
    SetTime(GetTimeHour()+8, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());
    DelayCommand(2.0, FloatingTextStringOnCreature("... You rested for 8 hours ...", oPC));
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        HenchmanRest(oHench);
        oHench = GetHenchman(oPC, ++i);
    }
    FriendRest(oPC);
}

// play rest animations
void RestAnimations(object oPC, float fDur)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPC);
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));

    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        AssignCommand(oHench, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
        oHench = GetHenchman(oPC, ++i);
    }
}

// player has pushed the rest button (see restduration.2da for duration)
void main()
{
    object oPC = GetLastPCRested();
    int nEvent = GetLastRestEventType();
    int nRestSuccessful = TRUE;

    if (nEvent == REST_EVENTTYPE_REST_STARTED)
    {
        if (!RestIsPossible(oPC))
        {
            AssignCommand(oPC, ClearAllActions()); // stop the rest
            FloatingTextStringOnCreature("... You cannot rest here ...", oPC);
            return;
        }
        BlackScreen(oPC);
        if (!RestInSafeZone(oPC))
        {
            object oEnc = RestGetEncounter(oPC);
            if (GetIsObjectValid(oEnc))
            {
                nRestSuccessful = FALSE;
                AssignCommand(oPC, ClearAllActions()); // stop the rest
                DelayCommand(1.0, RestEncounter(oPC, oEnc));
                DelayCommand(1.5, FloatingTextStringOnCreature("... Your rest is disturbed ...", oPC));
            }
        }
        DelayCommand(0.01, RestAnimations(oPC, 3.0));
        if (nRestSuccessful)
        {
            RestSetTired(oPC, FALSE);
            DelayCommand(1.00, Rest(oPC));
        }
        DelayCommand(2.00, FadeFromBlack(oPC));
    }
    else if (nEvent == REST_EVENTTYPE_REST_CANCELLED)
    {
    }
    else if (nEvent == REST_EVENTTYPE_REST_FINISHED)
    {
    }
}

/*
When the player rests, the nearest PJ encounter with tag "ENC_Rest" is
evaluated. If that encounter doesn't trigger, the next ENC_Rest encounter
is evaluated, and so on, until one encounter is triggered or no more
ENC_Rest encouters are found within the area. This allows you to define
different encounters for the different zones within an area (for example,
you might find trolls near the river and wolves near the edges of the woods).

You can set floating point variable HF_SP_LIMIT_DISTANCE_NEAR to something
like 1.0 if you want the spawned creatures to appear near to the player. This
defines how far away the spawns are when they appear near the resting player.
If you don't set this variable, the spawns will follow their PJ spawn location
which might be far away from the player.

You can define a "safe zone" for resting as follows:
If the player rests inside a trigger with tag HF_REST_SAFE_ZONE and all
doors within that trigger are closed, no rest encounters are triggered.

Use HF_REST_DISABLED to mark an area as entirely rest disabled.
*/
