//kills creature instantaneously when it spawns
//Author: Damian Brown (Luspr)
//Date: 05 Aug 2005
void main()
{
    SetIsDestroyable(FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
}
