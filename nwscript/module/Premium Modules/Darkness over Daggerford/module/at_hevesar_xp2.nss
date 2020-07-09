#include "hf_in_xp"
void main()
{
    //xp reward for completing the shadows in the fields quest
    if(GetLocalInt(GetModule(), "iShadowsXPGiven") == 0)
    {
        object oPC = GetPCSpeaker();
        GiveQuestXPToCreature(oPC, "j11", 100.0);
        SetLocalInt(GetModule(), "iShadowsXPGiven", 1);
    }
}
