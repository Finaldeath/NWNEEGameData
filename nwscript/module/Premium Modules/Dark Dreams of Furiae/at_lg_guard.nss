#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();

    SetPartyAsGuard();

    // Set as GOOD
    int iGoodEvil = GetGoodEvilValue(oPC);
    int iAdjustment = 0;
    if(iGoodEvil <= 70) iAdjustment = (70 - iGoodEvil) + 1;

    AdjustAlignment(oPC, ALIGNMENT_GOOD, iAdjustment, FALSE);

    // Set as Lawful
    int iLawChaos = GetLawChaosValue(oPC);
    iAdjustment = 0;
    if(iLawChaos <= 70) iAdjustment = (70 - iLawChaos) + 1;

    debug("good: " + IntToString(iGoodEvil) + ", law: " + IntToString(iLawChaos));

    AdjustAlignment(oPC, ALIGNMENT_LAWFUL, iAdjustment, FALSE);
}
