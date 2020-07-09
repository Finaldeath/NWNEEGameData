// B W-HUsey
// October 2005
// Salvatori offers the caravan duty sideuqest. Update the variable nSalvatori1Side to 1, and set the journal.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("Salvatori1Side",oPC,1);
    AddJournalQuestEntry("Caravan",10,oPC,TRUE);

}
