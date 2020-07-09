//To be placed as part of the actions taken of the journal giving conv.
//for the quests given by Astriel in the Chateu Elite
//since it is only info the PC is looking for then we need to set 'ints'
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
object oPC = GetPCSpeaker();
//int iJournal = GetLocalInt(GetModule(),"lock_down");
//if (iJournal == 2)
//   {
     AddJournalQuestEntry ("lock_down", 3, oPC, TRUE);
     SetLocalInt(GetModule(),"lock_down",3);
//    }
}
