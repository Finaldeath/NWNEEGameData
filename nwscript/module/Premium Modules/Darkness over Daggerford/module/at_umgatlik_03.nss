// this script should never be executed.
// it will get executed if Vetrixia fails to "rise" and become an undead

void main()
{
    object oPC = GetPCSpeaker();
    object oVetrixia = GetNearestObjectByTag("ks_vetrixia", oPC);
    if (GetIsDead(oVetrixia) || !GetIsObjectValid(oVetrixia))
    {
        location lLoc = GetLocation(OBJECT_SELF);
        AssignCommand(oVetrixia, SetIsDestroyable(TRUE, TRUE, TRUE));
        DestroyObject(oVetrixia);
        object oVetrixia = CreateObject(OBJECT_TYPE_CREATURE, "ks_vetrixia", lLoc);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DAZED_S), oVetrixia);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_RED), oVetrixia);
        AssignCommand(oVetrixia, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oVetrixia, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 6.0));
        SetLocalInt(oVetrixia, "UNDEAD", 1);
    }
}
