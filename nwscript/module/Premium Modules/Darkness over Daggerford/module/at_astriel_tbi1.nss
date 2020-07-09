//To be placed as part of the actions taken of the journal giving conv.
//for the quests given by Astriel in the Chateu Elite
//since it is only info the PC is looking for then we need to set 'ints'
//
//added the giving of the detection staff
//
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
    object oPC = GetPCSpeaker();
    int iJournal = GetLocalInt(GetModule(),"the_blackstone_inn");

    AddJournalQuestEntry ("the_dukes_killer", 3, oPC, TRUE);
    SetLocalInt(GetModule(),"the_dukes_killer",3);
    GiveXPToCreature(oPC, 250);

    if (iJournal == 0)
    {
        AddJournalQuestEntry ("the_blackstone_inn", 1, oPC, TRUE);
        SetLocalInt(GetModule(),"the_blackstone_inn",1);
        CreateItemOnObject("a2_detectstaff", oPC, 1);
    }

}
