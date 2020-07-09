//give the pc half of Astriel's payment upfront
//this version if a persuade attempt was successful
//Author: Damian Brown (Luspr)
//Date: 27-07-2005
#include "nw_i0_tool"
void main()
{
    object oPC = GetPCSpeaker();

    RewardPartyGP(500, oPC, FALSE);
    SetLocalInt(oPC, "astriel_persuade_true", 1);
    //sets that persuade was successful
    SetLocalInt(oPC, "astriel_pays", 1);
    //sets that the player cannot now ask to be paid again
}
