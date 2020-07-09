//::////////////////////////////////////////////////////////////////////////////
//:: nhb_id1_hlstrcow
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Heartbeat Event script for the Distraught Cows Halaster summons.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 15, 2006
//::////////////////////////////////////////////////////////////////////////////

const string COUNT = "ID1_COW_COUNT";

void main()
{
    object oThis = OBJECT_SELF;
    int nCount = GetLocalInt(oThis, COUNT);

    if (nCount == 3) // The cow explodes.
    {
        // Shower of gore.
        effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oThis);

        // Damage to everyone around.
        int nHitpoints = GetMaxHitPoints();
        effect eDamage = EffectDamage(nHitpoints);

        location lLoc = GetLocation(oThis);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, lLoc);
        float fDelay = 0.0;

        // Cycle all nearby targets.
        while (GetIsObjectValid(oTarget))
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));

            fDelay += 0.1;

            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0, lLoc);
        }

        // Damage to the cow.
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oThis);
    }
    else
    {
        // Keep counting.
        nCount++;

        SetLocalInt(oThis, COUNT, nCount);
    }

    // Update Oct 20, 2005 for Infinite Dungeons.
    // Determine if the creature is currently a follower.
    // If so run the henchmen AI otherwise run the default.
    // - Grant Mackay
    if (GetLocalInt(OBJECT_SELF, "bFollower"))
    {
        ExecuteScript("x0_ch_hen_heart", OBJECT_SELF);
    }
    else
    {
        ExecuteScript("nw_c2_default1", OBJECT_SELF);
    }
}
