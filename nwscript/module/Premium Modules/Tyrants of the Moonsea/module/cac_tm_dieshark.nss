//Shark in Mulmaster Docks dies from its wounds eventually

void main()
{
    DelayCommand(HoursToSeconds(1),
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF));
}
