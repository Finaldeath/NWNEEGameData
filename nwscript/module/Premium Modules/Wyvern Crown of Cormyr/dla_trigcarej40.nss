#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
    AddJournalQuestEntry("Careless",40,oPC);
    PartyGotEntry("Null",oPC,100,"XP Gain - thieves' lair found");
    DestroyObject(OBJECT_SELF,0.1);
    }
}
