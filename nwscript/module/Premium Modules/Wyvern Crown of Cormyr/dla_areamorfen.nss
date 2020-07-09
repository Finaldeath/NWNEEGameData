// dla_areamorfen
// June 2006
// B W-Husey
// Close the note journal entries
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
        AddJournalQuestEntry("Background",2,oPC,TRUE);
        AddJournalQuestEntry("Notes",2,oPC,TRUE);
        AddJournalQuestEntry("Henchmen",2,oPC,TRUE);
    }
}
