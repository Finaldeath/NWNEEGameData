//give the pc half of Astriel's payment
//this version if a persuade attempt was unsuccessful
//Author: Damian Brown (Luspr)
//Date: 27-07-2005
#include "nw_i0_tool"
void main()
{
    object oPC = GetPCSpeaker();
    RewardPartyGP(250, oPC, FALSE);
    SetLocalInt(oPC, "astriel_persuade_true", 2);
    //sets persuade was unsuccessful
    SetLocalInt(oPC, "astriel_pays", 1);
    //sets that the player cannot now ask to be paid again
}
