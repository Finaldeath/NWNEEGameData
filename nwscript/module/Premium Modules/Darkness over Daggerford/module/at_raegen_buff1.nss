// after successful influence, raegen gains helm's powers (buff)
// .. this occurs at the end of the game so it never needs to be dispelled

#include "hf_in_graphics"

void main()
{
    object oRaegen = GetObjectByTag("pm_raegen");
    effect eBuff;

    // heal
    eBuff = EffectHeal(500);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBuff, oRaegen);

    // fancy vfx for instant impact
    location lLoc = GetLocation(oRaegen);
    DrawCircle(lLoc, 2.5, VFX_IMP_DISPEL);
    DrawLineVert(lLoc, VFX_IMP_MAGBLUE, 8);

    // duration vfx
    eBuff = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);
    eBuff = EffectVisualEffect(VFX_DUR_BLUR);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);

    // combat buffs
    eBuff = EffectDamageShield(1, DAMAGE_BONUS_1d4, DAMAGE_TYPE_DIVINE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);

    eBuff = EffectACIncrease(5);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);

    eBuff = EffectDamageIncrease(DAMAGE_BONUS_5, DAMAGE_TYPE_MAGICAL);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);

    eBuff = EffectAttackIncrease(5, ATTACK_BONUS_MISC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);

    eBuff = EffectSpellResistanceIncrease(5);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);

    eBuff = EffectSavingThrowIncrease(SAVING_THROW_ALL, 5, SAVING_THROW_TYPE_ALL);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBuff, oRaegen);
}
