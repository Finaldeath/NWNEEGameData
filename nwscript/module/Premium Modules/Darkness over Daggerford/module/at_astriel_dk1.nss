//To be placed as part of the actions taken of the journal giving conv.
//for the quests given by Astriel in the Chateu Elite
//since it is only info the PC is looking for then we need to set 'ints'
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
    object oPC = GetPCSpeaker();
    int iJournal = GetLocalInt(GetModule(),"the_dukes_killer");

    AddJournalQuestEntry ("barge_activity", 5, oPC, TRUE);
    SetLocalInt(GetModule(),"barge_activity",5);
    SetLocalInt(GetModule(), "iBargeQuestGiven", 2);

    if (iJournal == 0)
    {
        AddJournalQuestEntry ("the_dukes_killer", 1, oPC, TRUE);
        SetLocalInt(GetModule(),"the_dukes_killer",1);
    }
}
