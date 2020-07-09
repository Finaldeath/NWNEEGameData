#include "hf_in_xp"
void main()
{
    //xp reward for completing the goblin kitchens quest
    if(GetLocalInt(GetModule(), "iKitchensXPGiven") == 0)
    {
        object oPC = GetPCSpeaker();
        GiveQuestXPToCreature(oPC, "j13", 100.0);
        SetLocalInt(GetModule(), "iKitchensXPGiven", 1);
    }
}
