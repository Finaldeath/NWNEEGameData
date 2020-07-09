void main()
{
    object oSkrinkles = GetNearestObjectByTag("id1_skrinkles");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPetrify(), oSkrinkles);
}
