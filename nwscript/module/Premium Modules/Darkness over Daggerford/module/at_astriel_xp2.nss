#include "hf_in_xp"
void main()
{
    //xp reward for completing the strange cargos quest
    object oPC = GetPCSpeaker();
    if(GetLocalInt(GetModule(), "iBargeActivityXPGiven") == 0)
    {
        SetLocalInt(GetModule(), "iBargeActivityXPGiven", 1);
        GiveQuestXPToCreature(oPC, "barge_activity", 100.0);
    }
}
