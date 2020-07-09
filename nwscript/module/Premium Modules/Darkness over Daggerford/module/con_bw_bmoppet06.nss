// summon baddies from red portal

void main()
{
    object oPC = GetPCSpeaker();
    int nBaddies = FloatToInt(IntToFloat(GetHitDice(oPC)) / 5);
    object oGate  = GetNearestObjectByTag("bw_ar0807_pred");

    nBaddies += 1;

    float fDelay = 0.2f;
    while (nBaddies > 0)
    {
        DelayCommand(fDelay, SignalEvent(oGate, EventUserDefined(501)));
        fDelay += 1.2f;
        nBaddies -= 1;
    }

    SetLocalInt(OBJECT_SELF, "nBaddyWave", 3);
}
