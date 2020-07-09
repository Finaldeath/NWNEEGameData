// January 2006
// B W-Husey
// Update the Guardian journal entries to completed if the PC got the keystones before the info

#include "nw_i0_plot"
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

if (HasItem(oPC,"Keystone1"))  AddJournalQuestEntry("Guardian1",20,oPC,TRUE);    //Update the journal
if (HasItem(oPC,"Keystone2"))  AddJournalQuestEntry("Guardian2",20,oPC,TRUE);    //Update the journal
if (HasItem(oPC,"Keystone3"))  AddJournalQuestEntry("Guardian3",20,oPC,TRUE);    //Update the journal


}
