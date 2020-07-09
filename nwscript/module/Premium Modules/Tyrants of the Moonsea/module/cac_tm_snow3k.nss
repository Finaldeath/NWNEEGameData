// secret: player kills zhent buried in snow

#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    object oZhent = OBJECT_SELF;
    effect eDeath = EffectDeath();
    effect eBlood = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlood, oZhent);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oZhent);
    AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 10);
}
