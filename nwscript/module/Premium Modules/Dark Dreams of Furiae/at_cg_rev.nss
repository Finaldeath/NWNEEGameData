#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();

    SetPartyAsRevolutionary();

    // Set as GOOD
    int iVal = GetGoodEvilValue(oPC);
    int iAdjustment = 0;
    if(iVal < 70) iAdjustment = (70 - iVal) + 1;
    AdjustAlignment(oPC, ALIGNMENT_GOOD, iAdjustment, FALSE);


    // Set as Neutral
    if(FALSE)
    {
        iVal = GetLawChaosValue(oPC);
        iAdjustment = 0;
        if(iVal >= 70 || iVal <= 30) iAdjustment = abs(50 - iVal);
        if(iVal >= 70) AdjustAlignment(oPC, ALIGNMENT_LAWFUL, iAdjustment, FALSE);
        if(iVal <= 30) AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, iAdjustment, FALSE);
    }

    // Set as Chaos
    if(TRUE)
    {
        iVal = GetLawChaosValue(oPC);
        iAdjustment = 0;
        if(iVal > 30) iAdjustment = (iVal - 30) + 1;
        AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, iAdjustment, FALSE);
    }
}
