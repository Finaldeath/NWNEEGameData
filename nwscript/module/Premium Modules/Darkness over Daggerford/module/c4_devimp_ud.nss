// user-defined event for abatorru's imp
// .. basically just pretend to attack skully

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Attack(object oTarget)
{
    // decide which sound to play
    string sSnd;
    int nCount = GetLocalInt(OBJECT_SELF, "nCryCounter");
    if (++nCount >= 3)
    {
        int n = d3();
        if      (n == 1) sSnd = "vs_nebraxxm_bat1";
        else if (n == 2) sSnd = "vs_nebraxxm_bat2";
        else if (n == 3) sSnd = "vs_nebraxxm_bat3";
        nCount = 0;
    }
    else
    {
        int n = d3();
        if      (n == 1) sSnd = "vs_nebraxxm_atk1";
        else if (n == 2) sSnd = "vs_nebraxxm_atk2";
        else if (n == 3) sSnd = "vs_nebraxxm_atk3";
    }
    PlaySound(sSnd);
    SetLocalInt(OBJECT_SELF, "nCryCounter", nCount);

    // attack our target
    ActionAttack(oTarget);
}

void Heartbeat()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
        return;

    object oSkully = GetNearestObjectByTag("ks_skully");
    if (GetIsObjectValid(oSkully))
    {
        AdjustReputation(oSkully, OBJECT_SELF, -100);
        ClearAllActions(TRUE);
        Attack(oSkully);
    }
}

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    if (nEvent == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nEvent == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
