// secret: snow zhent dies from fireball and pc is blessed by an evil god

#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    object oZhent = OBJECT_SELF;

    AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 25);

    effect eDeath = EffectDeath();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oZhent);

    GiveXPToCreature(oPC, 500);

    // level 15 divine favor
    int nDuration = 1;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int nScale = 5;
    effect eAttack = EffectAttackIncrease(nScale);
    effect eDamage = EffectDamageIncrease(nScale, DAMAGE_TYPE_MAGICAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, TurnsToSeconds(nDuration));
}
