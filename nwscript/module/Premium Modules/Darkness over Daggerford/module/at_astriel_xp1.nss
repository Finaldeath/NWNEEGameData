#include "hf_in_xp"
void main()
{
    //xp reward for completing the lockdown quest
    object oPC = GetPCSpeaker();
    if(GetLocalInt(GetModule(), "iLockdownXPGiven") == 0)
    {
        SetLocalInt(GetModule(), "iLockdownXPGiven", 1);
        GiveQuestXPToCreature(oPC, "j40", 100.0);
    }
}
