#include "ddf_util"
#include "x0_i0_partywide"

void UpdateNightmareJournal(object oPC)
{
    string text = "";
    object oModule = GetModule();

    int iUpdated = 0;
    int bFinished = FALSE;

    if(GetCurrentDay() > 5)
    {
        iUpdated += 2;
        text += "You have dreamt of dark things.";
        text += PARA + "Again, a dark force -- which you now identify as a being called Mog -- has plagued your sleep. Even... fed on you. This darkness appears to be behind the entire worldwine operation -- and she is not happy with your investigation.";
        text += PARA + "With so many of the links in the chain having been removed, you've crippled her plans. She's planning on bringing her anger down on this city like a hammer. She needs to be stopped.";
        text += PARA + "But you are so, so tired.";
    }
    else if (GetCurrentDay() > 4)
    {
        iUpdated += 1;
        text += "You have dreamt of dark things.";

        string sName = "Ulan";
        if(GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_COMPLETE)
        {
            //iUpdated += 4; // this is only here to force an update for debug purposes.
            sName = "Aladara";
        }

        text += PARA + "Having removed " + sName + " from the worldwine operation, you have apparently angered... *something.* Is there something lurking behind this worldwine operation?";
        text += PARA + "The answers are not immediately forthcoming. You're *very* tired. You need to solve this soon.";
    }

    if(GetLocalInt(oModule, "ddf_met_nightmare_karkualii") == TRUE)
    {
        bFinished = TRUE;
        iUpdated = 8;
        text += PARA + "You have found Mog -- a powerful night hag, lurking beneath the city and feeding on the dreams of worldwine users. She must be stopped.";
    }

    DoJournalUpdate(oPC, JOURNAL_NIGHTMARE, text, iUpdated, 6800, bFinished);

}

