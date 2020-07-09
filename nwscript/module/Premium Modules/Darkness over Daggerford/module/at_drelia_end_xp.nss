#include "hf_in_xp"
void main()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(GetModule(), "iShowdownXPAwarded") == 0)
    {
        SetLocalInt(GetModule(), "iShowdownXPAwarded", 1);
        GiveQuestXPToCreature(oPC, "j10", 100.0);
    }
}
