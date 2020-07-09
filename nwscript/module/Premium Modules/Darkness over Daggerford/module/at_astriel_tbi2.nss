//To be placed as part of the actions taken of the journal giving conv.
//for the quests given by Astriel in the Chateu Elite
//since it is only info the PC is looking for then we need to set 'ints'
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
object oPC = GetPCSpeaker();
int iJournal = GetLocalInt(GetModule(),"the_blackstone_inn");
if (iJournal == 1)
    {
     AddJournalQuestEntry ("the_blackstone_inn", 2, oPC, TRUE);
     SetLocalInt(GetModule(),"the_blackstone_inn",2);
    }
}
