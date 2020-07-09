// January 2006
// B W-Husey
// Castle Wyvernwater submerged
// Modified 24th March 2006

#include "x2_inc_toollib"

void main()
{
    // Applies slowing effect to all creatures, except sharks & other aquatic.
    object oPC = GetEnteringObject();
    effect eSlow = EffectMovementSpeedDecrease(50);
    effect eBubbles = EffectVisualEffect(VFX_DUR_BUBBLES);
    eBubbles = SupernaturalEffect(eBubbles);
    int nApp = GetAppearanceType(oPC);

    //exclude creatures that are not affected
    if (nApp==APPEARANCE_TYPE_ELEMENTAL_WATER || nApp==APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER || nApp==APPEARANCE_TYPE_SHARK_MAKO || nApp==APPEARANCE_TYPE_SHARK_HAMMERHEAD || nApp==APPEARANCE_TYPE_SHARK_GOBLIN)
    {
    return;
    }
    //lightly effected
    else if (nApp==APPEARANCE_TYPE_SAHUAGIN || nApp==APPEARANCE_TYPE_SAHUAGIN_CLERIC || nApp==APPEARANCE_TYPE_SAHUAGIN_LEADER)   //effected lightly only
    {
        eSlow = EffectMovementSpeedDecrease(20);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSlow,oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eBubbles,oPC);
    }
    //everyone else
    else
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSlow,oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eBubbles,oPC);
        SetLocalInt(OBJECT_SELF,"nDrownArea",1); //run heartbeat
    }
}
