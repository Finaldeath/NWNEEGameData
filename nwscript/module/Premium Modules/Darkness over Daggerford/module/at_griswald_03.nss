// griswald runs towards the drawbridge and gets wacked

void Die(object o)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MIRV_FLAME), o);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_FIRE), o);
    DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF));
    CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(o));
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_EXIT_RUN") == 0)
    {
        // first pass thru this script: griswald runs to gate
        SpeakString("Come out and fight Feldran!", TALKVOLUME_SHOUT);
        SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "WP_AR2000_GRISWALD_DEATH");
        SetLocalInt(OBJECT_SELF, "HF_EXIT_RUN", TRUE);
        SetLocalString(OBJECT_SELF, "HF_EXIT_SCRIPT", "at_griswald_03");
        ExecuteScript("hf_cs_exit", OBJECT_SELF);
    }
    else
    {
        // second pass thru this script: griswald dies
        object oPC = GetFirstPC();
        AddJournalQuestEntry("j85", 4, oPC);
        SetLocalInt(GetModule(), "nFandocGriswaldDead", 1);
        PlaySound("cb_sh_ballista");
        DelayCommand(0.5, Die(OBJECT_SELF));
    }
}
