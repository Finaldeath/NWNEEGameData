#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();

    SetPartyAsGuard();

    // Set as Lawful
    int iVal = GetLawChaosValue(oPC);
    int iAdjustment = 0;
    if(iVal < 70) iAdjustment = (70 - iVal) + 1;
    AdjustAlignment(oPC, ALIGNMENT_LAWFUL, iAdjustment, FALSE);


    // Set as Neurtal (good/evil)
    if(FALSE)
    {
        iVal = GetGoodEvilValue(oPC);
        iAdjustment = 0;
        if(iVal >= 70 || iVal <= 30) iAdjustment = abs(50 - iVal);
        if(iVal >= 70) AdjustAlignment(oPC, ALIGNMENT_GOOD, iAdjustment, FALSE);
        if(iVal <= 30) AdjustAlignment(oPC, ALIGNMENT_EVIL, iAdjustment, FALSE);
    }


    // set as EVIL
    iVal = GetGoodEvilValue(oPC);
    iAdjustment = 0;
    if(iVal > 30) iAdjustment = (iVal - 30) + 1;
    AdjustAlignment(oPC, ALIGNMENT_EVIL, iAdjustment, FALSE);


}
