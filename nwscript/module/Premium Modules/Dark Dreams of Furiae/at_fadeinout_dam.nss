void main()
{
    object oPC = GetPCSpeaker();

    effect eDam = EffectDamage(1, DAMAGE_TYPE_DIVINE);

    FadeToBlack(oPC);
    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
    DelayCommand(2.0, FadeFromBlack(oPC));
}
