void main()
{
    //script to handle burned hands in the drop off cave
    //luspr March 2006
    object oPC=GetPCSpeaker();
    effect eBurn=EffectDamage(d12(1),DAMAGE_TYPE_FIRE);
    effect eVisual=EffectVisualEffect(VFX_IMP_FLAME_M);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVisual,oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eBurn,oPC);
}
