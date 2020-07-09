// area enter script for zhentil keep warzone north

#include "hf_in_plot"

//Complete any journal entries for quests that cannot now be finished
void CompleteOutstandingJournalEntries(object oPC)
{
    int nStatus;

    //Complete journal for Gorlax the Many Eyed if incomplete
    nStatus = GetLocalInt(oPC, "NW_JOURNAL_ENTRYGorlaxtheManyEyed");
    if(nStatus >= 10 && nStatus < 70)
    {
        AddJournalQuestEntry("GorlaxtheManyEyed", 80, oPC);
    }

    //Complete journal for Pirates of the Moonsea if incomplete
    nStatus = GetLocalInt(oPC, "NW_JOURNAL_ENTRYPiratesoftheMoonsea");
    if(nStatus >= 10 && nStatus < 100)
    {
        AddJournalQuestEntry("PiratesoftheMoonsea", 120, oPC);
        //Destroy Dryden
        DestroyObject(GetObjectByTag("Dryden"));
    }

    //Complete journal for Zhentil Keep(Kornah) if incomplete
    nStatus = GetLocalInt(oPC, "NW_JOURNAL_ENTRYZhentilKeep");
    if(nStatus >= 10 && nStatus < 20)
    {
        AddJournalQuestEntry("ZhentilKeep", 30, oPC);
    }

    //Complete journal for Big Game Hunt if incomplete
    //Quest can still be completed if at 120 status
    nStatus = GetLocalInt(oPC, "NW_JOURNAL_ENTRYBigGameHunt");
    if(nStatus >= 10 && nStatus < 120)
    {
        AddJournalQuestEntry("BigGameHunt", 150, oPC);
    }

    //Complete journal for Big Game Hunt (Render) if incomplete
    nStatus = GetLocalInt(oPC, "NW_JOURNAL_ENTRYBigGameHunt-Render");
    if(nStatus >= 10 && nStatus < 30)
    {
        AddJournalQuestEntry("BigGameHunt-Render", 40, oPC);
    }

    //Complete journal for Big Game Hunt(Werebear) if incomplete
    nStatus = GetLocalInt(oPC, "NW_JOURNAL_ENTRYBigGameHunt-Werebear");
    if(nStatus >= 10 && nStatus < 50)
    {
        AddJournalQuestEntry("BigGameHunt-Werebear", 60, oPC);
    }

    //Complete journal for Big Game Hunt(Vaporandir) if incomplete
    nStatus = GetLocalInt(oPC, "NW_JOURNAL_ENTRYBigGameHunt-Vaporandir");
    if(nStatus >= 10 && nStatus < 50)
    {
        AddJournalQuestEntry("BigGameHunt-Vaporandir", 60, oPC);
    }
}

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        // automatically explore this urban area
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            object oKettia = GetNearestObjectByTag("CaptainKettia", oPC);

            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
            AddJournalQuestEntry("SoHighAPrice", 30, oPC);

            //Resolve outstanding journal entries that cannot now be completed
            CompleteOutstandingJournalEntries(oPC);

            //Kettia initiates dialog with PC
            AssignCommand(oKettia, ActionStartConversation(oPC));
        }
    }
}
