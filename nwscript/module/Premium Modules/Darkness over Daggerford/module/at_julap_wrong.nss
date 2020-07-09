// the player has guessed the wrong answer to one of Julap's riddles.
// .. apply a lame penalty

void main()
{
    object oPC = GetPCSpeaker();

    // take some gold
    int nGold = 100;
    TakeGoldFromCreature(nGold, oPC, TRUE);

    // take some XP
    //int nXP = GetXP(oPC) - 100;
    //SetXP(oPC, nXP);
    FloatingTextStringOnCreature("... gold lost ...", oPC);

    // apply some damage (mostly for effect ... it's not much of a punishment)
    int nDmg = 10;
    if (GetCurrentHitPoints(oPC) < nDmg)
    {
        nDmg = GetCurrentHitPoints(oPC) - 1;
    }
    if(nDmg > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDmg, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HARM), oPC);
        PlayVoiceChat(VOICE_CHAT_PAIN1, oPC);
        AssignCommand(oPC, ActionWait(1.0));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 4.0));
    }
}
