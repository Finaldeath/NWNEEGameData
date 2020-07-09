// January 2006
// B W-Husey
// Jump to Ball area portal
// The portal does not work without the portal keys
#include "x0_i0_partywide"

void main()
{
       object oPC = GetEnteringObject();
       if (GetItemPossessedByParty(oPC,"Keystone1")==OBJECT_INVALID ||
            GetItemPossessedByParty(oPC,"Keystone2")==OBJECT_INVALID ||
            GetItemPossessedByParty(oPC,"Keystone3")==OBJECT_INVALID)
            FloatingTextStringOnCreature("The portal does not seem to work", oPC);
        else
        {
           AssignCommand(oPC,JumpToObject(GetObjectByTag("CWPPortal1")));
           AddJournalQuestEntry("Mythallar",40,oPC);
           //Update the guardian journals - it's a catchall in case the PC never went to the keep.
            AddJournalQuestEntry("Guardian1",19,oPC);
            AddJournalQuestEntry("Guardian2",19,oPC);
            AddJournalQuestEntry("Guardian3",19,oPC);
        }
}
