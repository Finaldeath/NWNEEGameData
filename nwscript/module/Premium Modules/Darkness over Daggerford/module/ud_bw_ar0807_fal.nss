void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == 501) // fall damage
    {
        int nNth = 1;
        object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nNth);

        while (GetIsObjectValid(oPC))
        {
            if (GetLocalInt(oPC, "nAR0800_JumpedHole") == 1)
            {
                effect eKnock = EffectKnockdown();
                effect eDust = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
                effect eDam = EffectDamage(d6(4), DAMAGE_TYPE_BLUDGEONING);

                AssignCommand(oPC, ClearAllActions());

                DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oPC, 3.6f));
                DelayCommand(0.4f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDust, oPC));
                DelayCommand(0.6f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));

                DeleteLocalInt(oPC, "nAR0800_JumpedHole");
            }
            nNth += 1;
            oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nNth);
        }
    }
    else if (nEvent == 502) // signal gate - hack!
    {
        //SpeakString("502!");
        object oGate = GetNearestObjectByTag("bw_ar0807_pred");
        SignalEvent(oGate, EventUserDefined(501)); // summon baddy
    }
}
