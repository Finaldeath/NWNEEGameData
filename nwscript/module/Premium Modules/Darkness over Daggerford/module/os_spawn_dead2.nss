//kills creature instantaneously when it spawns
//Author: Damian Brown (Luspr)
//Date: 05 Aug 2005
//
//Updated by phil for his own nefarious deeds :-)
//Allows the creature to be selectable when dead

void main()
{
    SetIsDestroyable(FALSE,FALSE,TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
}
