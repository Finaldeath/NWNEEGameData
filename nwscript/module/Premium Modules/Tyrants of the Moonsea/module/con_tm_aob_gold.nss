// returns true if the player does not have has enough gold to pay for the selected blessing

#include "inc_aob"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return !AltarCanPlayerPay(oPC);
}
