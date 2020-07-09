//Prisoner on Pirate Ship reacts to being whipped

void main()
{
    effect eBlood = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);

    DelayCommand(0.6, PlayVoiceChat(VOICE_CHAT_PAIN1));
    DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlood, OBJECT_SELF));

    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }
}
