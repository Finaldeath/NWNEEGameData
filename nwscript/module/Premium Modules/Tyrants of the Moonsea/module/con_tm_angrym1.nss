// angrym only sells horses to players who do not already have them

#include "x3_inc_horse"

int StartingConditional()
{
    int nAllHaveHorses = TRUE;
    object oPC = GetPCSpeaker();

    object oPlayer = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oPlayer) && GetArea(oPlayer) == GetArea(oPC))
    {
        object oHorse = HorseGetHorse(oPlayer);
        if (!GetIsObjectValid(oHorse))
        {
            nAllHaveHorses = FALSE;
            break;
        }
        oPlayer = GetNextFactionMember(oPC, TRUE);
    }

    return !nAllHaveHorses;
}
