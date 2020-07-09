//Player puts wounded shark in Mulmaster Docks out of its misery

#include "hf_in_alignment"

void main()
{
    AdjustPlayerAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, 1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
}
