//::///////////////////////////////////////////////
//:: dla_atrumjournal
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Adds a joust rumour to the journal
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 29 June, 2006
//:://////////////////////////////////////////////
//Gale: Rewrote to fix problem with logic

void main()
{
    object oPC = GetPCSpeaker();
    int nRumour = GetLocalInt(OBJECT_SELF, "nMyRumour");
    int isSmall = GetCreatureSize(oPC)==CREATURE_SIZE_SMALL;
    int isDwarf = GetRacialType(oPC)  ==RACIAL_TYPE_DWARF;

    if (nRumour == 1) AddJournalQuestEntry("JRum11",1,oPC);
    else if (nRumour == 2) AddJournalQuestEntry("JRum21",1,oPC);
    else if (nRumour == 3) AddJournalQuestEntry("JRum31",1,oPC);
    else if (nRumour == 4) AddJournalQuestEntry("JRum41",1,oPC);
    else if (nRumour == 5) AddJournalQuestEntry("JRum51",1,oPC);
    else if (nRumour == 6 && !isSmall && !isDwarf)
             AddJournalQuestEntry("JRum61",1,oPC);
    else if (nRumour == 6 && (isSmall ||  isDwarf))
             AddJournalQuestEntry("JRum62",1,oPC);
    else if (nRumour == 22) AddJournalQuestEntry("JRum71",1,oPC);
    else if (nRumour == 23) AddJournalQuestEntry("JRum81",1,oPC);
}
