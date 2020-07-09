//::////////////////////////////////////////////////////////////////////////////
//:: phb_id1_hgtotem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Heartbeat Event script for the totems in Hagatha's cave. Each heartbeat
    the totem applies a lightning beam effect to the crystal it is corrupting
    or controlling.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 09, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_hagatha"

void main()
{
    object oThis = OBJECT_SELF;

    // The totem should only fire every third heartbeat.
    int nCounter = GetLocalInt(oThis, TOTEM_COUNTER_CURRENT);

    // If the count-down has not reached zero decrement.
    if (nCounter != 0)
    {
        nCounter--;
        SetLocalInt(oThis, TOTEM_COUNTER_CURRENT, nCounter);

        return;
    }

    nCounter = GetLocalInt(oThis, TOTEM_COUNTER_TOTAL);
    SetLocalInt(oThis, TOTEM_COUNTER_CURRENT, nCounter);

    object oHagatha = DB_GetObjectByTag(HAGATHA_TAG);

    int nPower = GetLocalInt(oThis, TOTEM_POWER);
    int nLevel = GetHitDice(oHagatha) - 2;

    // Just to be sure.
    if (nLevel < 1) nLevel = 1;

    float fDuration = 0.0;

    int nTarget, nDMG;
    effect eVFX_1, eVFX_2, eDMG; // 1 target, 2 self/target in case of beneficial.

    // Based on the local power constant establish the effect.
    switch (nPower)
    {
        case TOTEM_POWER_FIREBALL: // Totem explodes doing fire damage.
        {
            nTarget = TARGET_AOE;

            eVFX_1 = EffectVisualEffect(VFX_IMP_FLAME_M);
            eVFX_2 = EffectVisualEffect(VFX_FNF_FIREBALL);

            nDMG = d4(nLevel / 2);
            eDMG = EffectDamage(nDMG, DAMAGE_TYPE_FIRE);

            break;
        }
        case TOTEM_POWER_LIGHTNING: // Totem zaps a nearby enemy with lightning.
        {
            nTarget = TARGET_SINGLE;

            eVFX_1 = EffectBeam(VFX_BEAM_LIGHTNING, oThis, BODY_NODE_CHEST);
            eVFX_2 = EffectVisualEffect(VFX_IMP_LIGHTNING_S);

            nDMG = d4(nLevel);
            eDMG = EffectDamage(nDMG, DAMAGE_TYPE_ELECTRICAL);

            break;
        }
        case TOTEM_POWER_WIND: // Totem unleashes a wind effect, knocking down.
        {
            nTarget = TARGET_AOE;

            eVFX_1 = EffectVisualEffect(VFX_IMP_DOOM);
            eVFX_2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);

            fDuration = IntToFloat(nLevel) / 4.0;

            eDMG = EffectKnockdown();

            break;
        }
        case TOTEM_POWER_DAMAGE_REDUCTION: // Damage shield for the boss.
        {
            nTarget = TARGET_BOSS;

            eVFX_1 = EffectBeam(VFX_BEAM_COLD, oThis, BODY_NODE_CHEST);
            eVFX_2 = EffectVisualEffect(VFX_IMP_GLOBE_USE);

            fDuration = 100.0;

            nDMG = nLevel * 2;
            eDMG = EffectDamageReduction(nDMG, DAMAGE_POWER_PLUS_TWENTY, nLevel + (nLevel -1));

            break;
        }
        case TOTEM_POWER_DAMAGE_INCREASE: // Damage increase for the boss.
        {
            nTarget = TARGET_BOSS;

            eVFX_1 = EffectBeam(VFX_BEAM_EVIL, oThis, BODY_NODE_CHEST);
            eVFX_2 = EffectVisualEffect(VFX_IMP_EVIL_HELP);

            fDuration = IntToFloat(nLevel) * 2.0;

            eDMG = EffectAbilityIncrease(ABILITY_STRENGTH, 10);

            break;
        }
        case TOTEM_POWER_HEAL: // Heal for the boss.
        {
            nTarget = TARGET_BOSS;

            eVFX_1 = EffectBeam(VFX_BEAM_HOLY, oThis, BODY_NODE_CHEST);
            eVFX_2 = EffectVisualEffect(VFX_IMP_HEALING_S);

            nDMG = d4(nLevel);
            eDMG = EffectHeal(nDMG);

            break;
        }
        default:
        {
            DebugMessage("phb_id1_hgtotem::main() - Unrecognized totem power.");
            break;
        }
    }

    // DEBUG information.
    DebugMessage("nLevel = " + IntToString(nLevel));
    DebugMessage("nDMG = " + IntToString(nDMG));

    // Have the totem work it's magic.
    object oTarget = OBJECT_INVALID;
    float fDelay = 0.0;

    // Apply visual effects and damage/status effects based on target type.
    switch (nTarget)
    {
        case TARGET_SINGLE:
        {
            // Target is the nearest player.
            //oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
            oTarget = GetFirstPC();

            float fDistance = GetDistanceBetween(oThis, oTarget);

            int nDis = fDistance <= 20.0;
            int nLOS = LineOfSightObject(oThis, oTarget);

            if (GetIsObjectValid(oTarget) && nDis && nLOS)
            {
                // Damage effect.
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oTarget);

                // Visual effects. VFX 1 is applied to target, 2 to self.
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX_1, oTarget, 2.0);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX_2, oThis);
            }

            break;
        }
        case TARGET_AOE:
        {
            // Target is everything within 20 yards that isn't Hagatha.
            location lLoc = GetLocation(oThis);

            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, lLoc, TRUE);

            // Visual effects. VFX 1 is applied to the target, 2 to self.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX_2, oThis);

            while (GetIsObjectValid(oTarget))
            {
                if (oTarget == oHagatha)
                {
                    oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0, lLoc, TRUE);
                    continue; // Don't hit hagatha.
                }

                // Damage or status effect.
                if (fDuration == 0.0) // Instant effects.
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oTarget));
                }
                else // Temporary effects.
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDMG, oTarget, fDuration));
                }

                // Visual effects. VFX 1 is applied to the target, 2 to self.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX_1, oTarget));

                fDelay += 0.1;
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0, lLoc, TRUE);
            }

            break;
        }
        case TARGET_BOSS:
        {
            // Target is Hagatha.
            oTarget = oHagatha;

            if (GetIsObjectValid(oTarget))
            {
                // Heal or beneficial effect.
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oTarget);

                // Visual effects. VFX 1 and 2 are applied to the target.
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX_1, oTarget, 2.0);
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX_2, oTarget));
            }

            break;
        }
        default:
        {
            DebugMessage("phb_id1_hgtotem::main() - Unrecognized target type.");
            break;
        }
    } // end switch.
}
