// open red portal, summon baddy

void MakeRedGate(location lLoc);

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, SetCameraFacing(80.0, 20.0, 60.0));

    object oRedWP  = GetObjectByTag("wp_ar0807_red");
    location lRedWP = GetLocation(oRedWP);

    effect eEvil = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eSum = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEvil, lRedWP);
    DelayCommand(0.6f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSum, lRedWP));

    DelayCommand(1.4f, MakeRedGate(lRedWP));

    SetLocalInt(OBJECT_SELF, "nRedPortal", 1);
    SetLocalInt(OBJECT_SELF, "nBaddyWave", 1);
}

void MakeRedGate(location lLoc)
{
    object oGate = CreateObject(OBJECT_TYPE_PLACEABLE, "bw_ar0807_pred", lLoc);

    object oSound = GetNearestObjectByTag("ar0807_sound");
    SoundObjectSetVolume(oSound, 127);
    SoundObjectPlay(oSound);

    AssignCommand(oGate, DelayCommand(1.2f, SignalEvent(oGate, EventUserDefined(501))));
    SetLocalObject(OBJECT_SELF, "oGate", oGate);
}
