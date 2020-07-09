// January 2006
// B W-Husey
// Combined strength check on the stone

#include "cu_functions"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nStrength = GetAbilityScore(oPC, ABILITY_STRENGTH)+
                    GetAbilityScore(ReturnHenchman(oPC,1), ABILITY_STRENGTH)+
                    GetAbilityScore(ReturnHenchman(oPC,2), ABILITY_STRENGTH);

    if(nStrength > 50)
        return TRUE;

    return FALSE;
}
