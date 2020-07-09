#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();
    int iVal;
    int iAdjustment;

    SetPartyAsGuard();

    // Set as GOOD
    if(FALSE)
    {
        iVal = GetGoodEvilValue(oPC);
        iAdjustment = 0;
        if(iVal < 70) iAdjustment = (70 - iVal) + 1;
        AdjustAlignment(oPC, ALIGNMENT_GOOD, iAdjustment, FALSE);
    }

    // Set as Neutral (law/chaos)
    iVal = GetLawChaosValue(oPC);
    iAdjustment = 0;
    if(iVal >= 70 || iVal <= 30) iAdjustment = abs(50 - iVal);
    if(iVal >= 70) AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, iAdjustment, FALSE);
    if(iVal <= 30) AdjustAlignment(oPC, ALIGNMENT_LAWFUL, iAdjustment, FALSE);


    // Set as Neutral (good/evil)
    iVal = GetGoodEvilValue(oPC);
    iAdjustment = 0;
    if(iVal >= 70 || iVal <= 30) iAdjustment = abs(50 - iVal);
    if(iVal >= 70) AdjustAlignment(oPC, ALIGNMENT_EVIL, iAdjustment, FALSE);
    if(iVal <= 30) AdjustAlignment(oPC, ALIGNMENT_GOOD, iAdjustment, FALSE);

}
