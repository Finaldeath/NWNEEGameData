//Adds jousting info to the journal from Huntcrown.

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("JRum11",1,oPC);
    AddJournalQuestEntry("JRum41",1,oPC);
    if (GetCreatureSize(oPC)!=CREATURE_SIZE_SMALL && GetRacialType(oPC)!=RACIAL_TYPE_DWARF) AddJournalQuestEntry("JRum61",1,oPC);
    else AddJournalQuestEntry("JRum62",1,oPC);
}
