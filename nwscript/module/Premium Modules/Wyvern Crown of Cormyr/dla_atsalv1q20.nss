// B W-HUsey
// October 2005
// PC refuses the caravan duty sideuqest. Update the variable nSalvatori1Side to 20, and set the journal.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("Salvatori1Side",oPC,20);
    AddJournalQuestEntry("Caravan",50,oPC,TRUE);
}
