//Elventree view from Swaying Bough balcony gives xp bonus to rangers and druids
void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nEntered") == 0))
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        int nNatureClasses = GetLevelByClass(CLASS_TYPE_DRUID, oPC) +
                             GetLevelByClass(CLASS_TYPE_RANGER, oPC);

        if(nNatureClasses > 0)
        {
            effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, 2);
            effect eEmp = EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, 4);
            effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWis, oPC, HoursToSeconds(12));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEmp, oPC, HoursToSeconds(12));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);

            AssignCommand(oPC,
                SpeakString("The breathtaking view of nature and man in perfect harmony " +
                            "reinforces your beliefs and makes you feel " +
                            "truly at one with the land."));
            DelayCommand(1.0, GiveXPToCreature(oPC, 150));
        }
    }
}
