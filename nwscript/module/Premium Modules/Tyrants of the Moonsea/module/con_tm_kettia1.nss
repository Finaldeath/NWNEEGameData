// returns true if the party is mounted

#include "hf_in_horse"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return HorsePartyIsMounted(oPC);
}
