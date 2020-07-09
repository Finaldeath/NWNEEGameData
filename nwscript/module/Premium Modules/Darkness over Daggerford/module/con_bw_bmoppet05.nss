// summon baddy from red portal

void main()
{
    object oGate  = GetNearestObjectByTag("bw_ar0807_pred");
    SignalEvent(oGate, EventUserDefined(501));

    SetLocalInt(OBJECT_SELF, "nBaddyWave", 2);
}
