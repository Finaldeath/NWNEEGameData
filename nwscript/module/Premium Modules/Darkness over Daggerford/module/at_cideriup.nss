void main()
{
    object oPC = GetPCSpeaker();
    //effect name with respectful tip of the cap to The Wurzels...
    effect eCiderIUpLandlord = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCiderIUpLandlord, oPC, 60.0);

}
