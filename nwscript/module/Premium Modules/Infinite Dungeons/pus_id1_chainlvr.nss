//::////////////////////////////////////////////////////////////////////////////
//:: pus_id1_chainlvr
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Used Event script for the chain lever in Harat's area. Causes chains
    (beam effects) to snare any creatures in the chain trigger's list.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 4, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"

const string LEVER_ACTIVATED = "bActivated";

void main()
{

    // Objects to be used.
    object oThis = OBJECT_SELF;
    object oUser = GetLastUsedBy();

    int bSurrender = GetLocalInt(GetModule(), "bHaratSurrender");
    int bHostile = GetLocalInt(GetModule(), "bHaratHostile");

    // If Harat has surrendered the trap should no longer be active unless he
    // is hostile (the player decided to kill him anyway).
    if (bSurrender && !bHostile)
    {
        FloatingTextStringOnCreature("The lever is not currently functioning.", oUser, TRUE);
        return;
    }

    // Check to make sure the level is currently in a state where it can be used.
    if (GetLocalInt(oThis, LEVER_COOLDOWN))
    {
        FloatingTextStringOnCreature("This cannot be used again so soon.", oUser, TRUE);
        return;
    }

    // Play a lever pulling animation and flag the lever as unusable.
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    SetLocalInt(oThis, LEVER_COOLDOWN, TRUE);

    // A short time later play the opposite animation and flag as usable again.
    DelayCommand(CHAIN_DURATION + 5.0, SetLocalInt(oThis, LEVER_COOLDOWN, FALSE));
    DelayCommand(CHAIN_DURATION + 5.0, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    object oHarat = DB_GetObjectByTag(HARAT_TAG);

    int nLevel = GetHitDice(oHarat);

    // The relevant trigger and chain sources should be gathered based on
    // variables stored locally.
    int nTrigger = GetLocalInt(oThis, N_CHAIN_TRIGGER);
    int nSource1 = GetLocalInt(oThis, N_CHAIN_SOURCE_1);
    int nSource2 = GetLocalInt(oThis, N_CHAIN_SOURCE_2);
    int nSource3 = GetLocalInt(oThis, N_CHAIN_SOURCE_3);
    int nSource4 = GetLocalInt(oThis, N_CHAIN_SOURCE_4);

    object oTrigger = DB_GetObjectByTag(CHAIN_TRIGGER_PRFX + IntToString(nTrigger));
    object oSource1 = DB_GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource1));
    object oSource2 = DB_GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource2));
    object oSource3 = DB_GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource3));
    object oSource4 = DB_GetObjectByTag(CHAIN_SOURCE_PRFX + IntToString(nSource4));

    /*
    if (!GetLocalInt(oThis, LEVER_ACTIVATED))
    {
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(oThis, LEVER_ACTIVATED, TRUE);
    }
    else
    {
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetLocalInt(oThis, LEVER_ACTIVATED, FALSE);
    }
    */
    // Apply a beam and paralysis effect to everyone on the trigger.
    effect ePara = EffectCutsceneImmobilize();
    effect eDamage = EffectDamage(d4(nLevel), DAMAGE_TYPE_PIERCING);

    int nObjects = GetLocalInt(oTrigger, CHAIN_TRIGGER_OBJECT_NUM);
    int i;

    object oTarget;

    effect eVFX_1;
    effect eVFX_2;

    // Cycle the objects stored on the trigger.
    for (i = 1; i <= nObjects; ++i)
    {
        oTarget = GetLocalObject(oTrigger, CHAIN_TRIGGER_OBJECT_PRFX
            + IntToString(i));

        // Error checking.
        if (!GetIsObjectValid(oTarget))
        {
            DebugMessage("pus_id1_chainlvr::main() invalid object stored on "
                + "chain trigger, index: " + IntToString(i));
        }

        // Debug tracking for strange case.
        if (oTarget == oThis)
        {
            DebugMessage("pus_id1_chainlvr::main() - Lever targeted by chain trap.");
            continue;
        }

        // Stop the target from doing anything that will break the VFX etc.
        DebugMessage("Clearing actions. Point 37.");
        AssignCommand(oTarget, ClearAllActions(TRUE));

        // Create the beam effects.
        eVFX_1 = EffectBeam(VFX_BEAM_CHAIN, oTarget, BODY_NODE_CHEST);

        // Throw the beams and the paralysis effect.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX_1, oSource1, CHAIN_DURATION);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX_1, oSource2, CHAIN_DURATION);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX_1, oSource3, CHAIN_DURATION);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX_1, oSource4, CHAIN_DURATION);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, CHAIN_DURATION);

        // Update march 21, 2006. If a player dies and then respawns while
        // trapped by the chains it will leave the chan effect in place. In
        // order to avoid this don't allow the player to die so long as they are
        // trapped by the chains.
        if (GetIsPC(oTarget))
        {
            SetImmortal(oTarget, TRUE);
            DelayCommand(CHAIN_DURATION, SetImmortal(oTarget, FALSE));
        }

        // If Harat is chained a special int should be set to dis-allow his
        // teleport and have his invulnerabilty removed.
        if (GetTag(oTarget) == HARAT_TAG)
        {
            SetLocalInt(oTarget, HARAT_TELEPORT_PROHIBITED, TRUE);
            DelayCommand(CHAIN_DURATION, SetLocalInt(oTarget, HARAT_TELEPORT_PROHIBITED, FALSE));

            RemoveDemonShield(oTarget);
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
    }
}
