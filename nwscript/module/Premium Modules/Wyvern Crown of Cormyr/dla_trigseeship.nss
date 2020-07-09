// PC and party seen the pirate ship
#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
    AddJournalQuestEntry("Piracy",30,oPC);
    DestroyObject(OBJECT_SELF);
    }
}
