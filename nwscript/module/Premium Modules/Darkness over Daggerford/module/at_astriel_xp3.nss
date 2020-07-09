#include "hf_in_xp"
#include "x0_i0_partywide"
void main()
{
    //xp reward for completing the black stome inn quest
    object oPC = GetPCSpeaker();
    if(GetLocalInt(GetModule(), "iBlackstoneResolved") == 0)
    {
        SetLocalInt(GetModule(), "iBlackstoneResolved", 1);
        GiveQuestXPToCreature(oPC, "the_blackstone_inn", 100.0);
        //remove the rod of detection
        RemoveItemFromParty(oPC, "a2_detectstaff");
    }
}
