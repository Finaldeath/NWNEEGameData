//::////////////////////////////////////////////////////////////////////////////
//:: itm_id1_harattg
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Activate event script for the 'Harat's Tongue' unique boss item. When
    activated the tongue conjures a ball of hellfire damaging all creatures
    within a large radius (hostile or friendly). The effect of this item is
    essentially the same as the epic hellball spell and scripted using the same
    basic code. See x2_s2_hellball.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Nov. 16, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"
#include "inc_id1_debug"

void main()
{
//    int nEvent = GetUserDefinedEventNumber();

    // Item activated event.
//    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
//    {
         // Gather user, item and target location.
        object oUser = GetItemActivator();
        object oItem = GetItemActivated();
        location lTarget = GetItemActivatedTargetLocation();

        // Clear the user's action queue to avoid interruptions to the item's power.
        DebugMessage("Clearing actions. Point 19.");
        AssignCommand(oUser, ClearAllActions(TRUE));

        // Damage caused is based on the item's level.
        //string sTag = GetTag(oItem);
        //int nLength = GetStringLength(sTag);
        //int nLevel = StringToInt(GetSubString(sTag, (nLength - 2), 2));
        int nLevel = GetHitDice(oUser);
        int nSaveDC = nLevel + 10;

        // Establish visual effects.
        effect eVFXAcid = EffectVisualEffect(VFX_IMP_ACID_L);
        effect eVFXElectric = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        effect eVFXFire = EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eVFXHoly = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        effect eVFXExplode = EffectVisualEffect(464);

        // Status effect
        effect eKnockdown = EffectKnockdown();

        // Apply the main explosion effect.
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFXExplode, lTarget);

        // Apply damage to all possible targets.
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lTarget,
            TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);

        // Damage totals.
        int nDMGAcid, nDMGElectric, nDMGFire, nDMGHoly, nDMGTotal;

        // Damage effects.
        effect eDMGAcid, eDMGElectric, eDMGFire, eDMGHoly;

        // Saving throw results.
        int nSave;

        // Delay.
        float fDelay;

        while (GetIsObjectValid(oTarget))
        {
            // Determine damage by target.
            nDMGAcid = d4(nLevel);
            nDMGElectric = d4(nLevel);
            nDMGFire = d4(nLevel);
            nDMGHoly = d4(nLevel);

            // Determine delay to target.
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20 + 0.5f;

            nSave = ReflexSave(oTarget, nSaveDC, SAVING_THROW_TYPE_EVIL, oUser);

            if (nSave > 0)
            {
                nDMGAcid /=2;
                nDMGElectric /=2;
                nDMGFire /=2;
                nDMGHoly /=2;
            }

            if (GetIsFriend(oTarget, oUser))
            {
                nDMGAcid /=2;
                nDMGElectric /=2;
                nDMGFire /=2;
                nDMGHoly /=2;
            }

            nDMGTotal = nDMGAcid + nDMGElectric + nDMGFire + nDMGHoly;

            if (nDMGTotal > 50)
            {
                DelayCommand(fDelay + 0.3,
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown,
                        oTarget, 3.0));
            }

            //Initialize damage effects.
            eDMGAcid = EffectDamage(nDMGAcid, DAMAGE_TYPE_ACID);
            eDMGElectric = EffectDamage(nDMGElectric, DAMAGE_TYPE_ELECTRICAL);
            eDMGFire = EffectDamage(nDMGFire, DAMAGE_TYPE_FIRE);
            eDMGHoly = EffectDamage(nDMGHoly, DAMAGE_TYPE_DIVINE);

            // Apply damage effects.
            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMGAcid, oTarget));

            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMGElectric, oTarget));

            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMGFire, oTarget));

            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMGHoly, oTarget));

            // Apply visual effects.
            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXAcid, oTarget));

            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXElectric, oTarget));

            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXFire, oTarget));

            DelayCommand(fDelay,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXHoly, oTarget));

            //Select the next target within the spell shape.
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE,
                OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
        } // end while
//    } // X2_ITEM_EVENT_ACTIVATE
}
