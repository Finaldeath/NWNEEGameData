void main()
{
    object oPC = GetPCSpeaker();
    object oAltar = GetNearestObjectByTag("ks_bhaal_altar2", oPC);

    effect eGas = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    effect eHarm = EffectVisualEffect(VFX_IMP_HARM);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eGas, oAltar);
    SetFacingPoint(GetPosition(oPC));

    if(GetLocalInt(GetModule(), "iDamagedFromFake") == 0)
    {
        GiveXPToCreature(oPC, 500);
        ActionPauseConversation();
        effect eDamage = EffectDamage(GetCurrentHitPoints(OBJECT_SELF) / 2);
        effect eBones = EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL);
        DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHarm, OBJECT_SELF));
        DelayCommand(1.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF));
        DelayCommand(1.75, SetLocalInt(GetModule(), "iDamagedFromFake", 1));
        DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_DEATH, OBJECT_SELF));
        DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBones, OBJECT_SELF));
        DelayCommand(4.0, ActionResumeConversation());
    }
}
