#include "hf_in_xp"
void main()
{
    //xp reward for completing the abducted shepherds quest
    if(GetLocalInt(GetModule(), "iShepherdsXPGiven") == 0)
    {
        object oPC = GetPCSpeaker();
        GiveQuestXPToCreature(oPC, "j12", 100.0);
        SetLocalInt(GetModule(), "iShepherdsXPGiven", 1);
    }
}
