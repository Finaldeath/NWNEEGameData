#include "x3_inc_horse"

void main()
{
    object oPC = GetFirstPC();
    HorseCreateHorse("x3_horse001", GetLocation(oPC), oPC);
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        if (GetIsPlayableRacialType(oHench))
        {
            HorseCreateHorse("x3_horse001", GetLocation(oHench), oHench);
        }
        oHench = GetHenchman(oPC, ++i);
    }
}
