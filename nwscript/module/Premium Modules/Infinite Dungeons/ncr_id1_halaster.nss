//::////////////////////////////////////////////////////////////////////////////
//:: ncr_id1_halaster
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Combat Round End script for Halaster.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_halaster"

// Name: Jump and Heal
//
// Defined in: ncr_id1_halaster
//
// Has the action subject (halaster) do a disappear appear animation an heal
// themselves if unless it is determined that halaster has surrendered.
//
// Parameters:
// NONE
//
// Return:
// NONE
void JumpAndHeal();

void main()
{
    object oThis = OBJECT_SELF;
    int nCounter = GetLocalInt(oThis, SUMMON_COUNTER);

    if (nCounter == 0)
    {
        // Halaster points to a portal inticing it to summon a creature.
        int nRand = Random(8) + 1;
        int nCount = 0;
        object oPortal = DB_GetObjectByTag(PORTAL_PRFX + IntToString(nRand));

        // Double check the portals validity to avoid pointing at nothing.
        while (!GetIsObjectValid(oPortal))
        {
            nRand++;
            nCount++;

            // If the count is > 7 all portals have been tried and found
            // invalid. In this case execute default handling and return.
            if (nCount > 7)
            {
                // Jump the count-down to avoid running this code repeatedly.
                SetLocalInt(oThis, SUMMON_COUNTER, 100);

                ExecuteScript("nw_c2_default3", OBJECT_SELF);

                return;
            }

            if (nRand > 8) nRand = 1; // Overflow handling; there are 8 portals.

            oPortal = DB_GetObjectByTag(PORTAL_PRFX + IntToString(nRand));
        }

        float fDirection = GetDirection(oThis, oPortal);

        DebugMessage("Clearing actions. Point 23.");
        ClearAllActions(TRUE);

        SetFacing(fDirection);

        ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.0);

        DelayCommand(1.0, AssignCommand(oPortal, SummonMonster()));

        // Establish a new count down.
        nCounter = Random(4) + 3; // 3-6 rounds.

        SetLocalInt(oThis, SUMMON_COUNTER, nCounter);

        // Have Halaster jump away and heal while the players deal with the monsters.
        DelayCommand(2.0, JumpAndHeal());

        // Ensure that no other actions overwrite the pointing animation for 2 seconds.
        DelayCommand(2.0, SetCommandable(TRUE));

        SetCommandable(FALSE);
    }
    else // Decrement the count down and continue.
    {
        nCounter--;

        SetLocalInt(oThis, SUMMON_COUNTER, nCounter);
    }

    // Default handling.
    ExecuteScript("nw_c2_default3", OBJECT_SELF);
}

//::////////////////////////////////////////////////////////////////////////////
//:: JumpAndHeal
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: April 5, 2006
//::////////////////////////////////////////////////////////////////////////////
void JumpAndHeal()
{
    int bSurrender = GetLocalInt(GetModule(), "bHalasterSurrender");

    if (bSurrender) return;

    object oThis = OBJECT_SELF;
    int nHeal = GetMaxHitPoints()/2;
    location lLoc = GetLocation(oThis);
    effect eJump = EffectDisappearAppear(lLoc);
    effect eHeal = EffectHeal(nHeal);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eJump, oThis, 10.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oThis);
}
