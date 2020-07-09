void main()
{
    object oPC = GetFirstPC();
    object oHench = GetHenchman(oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), oHench);
}
