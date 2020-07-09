#include "X0_I0_PARTYWIDE"

void main()
{
    SetLocalInt(OBJECT_SELF, "nAlliance", 1);

    object oTrogs = GetObjectByTag("f_trogs");
    object oPC = GetPCSpeaker();

    ClearPersonalReputationWithFaction(oPC, oTrogs);
    AdjustReputationWithFaction(oPC, oTrogs, 50); // to neutral
}
