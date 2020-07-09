//::////////////////////////////////////////////////////////////////////////////
//:: phb_id1_rncrcl
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Heartbeat Event script for the rune circles in Halaster's area. If
    Halaster is standing within the circle it will heal him for 1/5th of his
    total Hitpoints.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Dec 2, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

void main()
{
    object oHalaster = DB_GetObjectByTag(HALASTER_TAG);
    float fDistance = GetDistanceToObject(oHalaster);

    // Inside the rune circle.
    if (fDistance <= 4.0)
    {
        int nHitpoints = GetMaxHitPoints(oHalaster);
        float fHeal = IntToFloat(nHitpoints) * 0.4;
        int nHeal = FloatToInt(fHeal);

        DebugMessage("phb_id1_rncrcl::main() nHeal = " + IntToString(nHeal));

        // Apply a heal and a visual to Halaster.
        effect eHeal = EffectHeal(nHeal);
        effect eVFX = EffectVisualEffect(VFX_IMP_HEALING_G);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oHalaster);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oHalaster);

        // Apply a visual to the circle to indicate it's doing something.
        eVFX = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);

        //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, OBJECT_SELF, 6.0);
    }
}
