#include "hf_in_xp"
#include "nw_i0_tool"
void main()
{
    object oPC = GetPCSpeaker();
    RewardPartyGP(250, oPC, FALSE);
    GiveQuestXPToCreature(oPC, "j201", 100.0);
    SetLocalInt(oPC, "astriel_pays", 2);
    //sets that the player cannot now ask to be paid again
}
