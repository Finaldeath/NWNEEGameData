//To be placed as part of the actions taken of the journal giving conv.
//for the quests given by Astriel in the Chateu Elite
//since it is only info the PC is looking for then we need to set 'ints'
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
    object oPC = GetPCSpeaker();
    int iJournal = GetLocalInt(GetModule(),"the_blackstone_inn");
    if (iJournal == 2)
    {
         AddJournalQuestEntry ("the_blackstone_inn", 3, oPC, TRUE);
         SetLocalInt(GetModule(),"the_blackstone_inn",3);
         //now all astriel quests are done - unlock all the gates
         SetLocked(GetObjectByTag("AR0500_AR0700_EXIT"), FALSE);
         SetLocked(GetObjectByTag("C1AR0500_0401_EXIT"), FALSE);
         SetLocked(GetObjectByTag("AR0500_AR0800_EXIT"), FALSE);
         SetLocked(GetObjectByTag("pm_rivergate"), FALSE);
         SetLocalInt(GetModule(),"pm_Daggerford_open",1);
         //Destroy the farmers in the happy cow tavern
         DestroyObject(GetObjectByTag("db_gaslo1",0));
         DestroyObject(GetObjectByTag("pm_hevesar",0));
         DestroyObject(GetObjectByTag("db_rorry1",0));
    }
}
