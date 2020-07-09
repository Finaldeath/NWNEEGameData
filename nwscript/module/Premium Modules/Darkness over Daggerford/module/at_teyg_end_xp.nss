#include "hf_in_xp"
void main()
{
    object oPC = GetPCSpeaker();

    //if drelia is dead close down the relevant journal
    if(GetLocalInt(GetModule(), "drelia_dead") ==1)
    {
        AddJournalQuestEntry("j10", 9, oPC, TRUE);
        if(GetLocalInt(GetModule(), "iShowdownXPAwarded") == 0)
        {
            GiveQuestXPToCreature(oPC, "j10", 100.0);
            SetLocalInt(GetModule(), "iShowdownXPAwarded", 1);
        }

    }
    //otherwise it stays open until the player reports back to Drelia
    else
    {
        AddJournalQuestEntry("j10", 7, oPC, TRUE);
    }
}
