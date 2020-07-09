// November 2005
// Set journal entry of the party of the PC when this NPC is killed

#include "cu_functions"
void main()
{
    object oPC = GetFirstPC(); //since this is a one party mod, this is the safect way.
    object oPC2 = GetLastKiller(); //just in case!
    AllParty("nDamsel",oPC,4);
    AllParty("nDamsel",oPC2,4);
    AddJournalQuestEntry("Damsel",30,oPC);
    AddJournalQuestEntry("Damsel",30,oPC2);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
