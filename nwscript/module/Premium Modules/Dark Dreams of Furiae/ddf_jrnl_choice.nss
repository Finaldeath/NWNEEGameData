#include "ddf_util"
#include "x0_i0_partywide"

void UpdateChoiceJournal(object oPC)
{
    string text = "";
    object oModule = GetModule();

    int iUpdated = 0;
    int bFinished = FALSE;

    if(GetLocalInt(oModule, "ddf_karkualii_defeated") == TRUE)
    {
        iUpdated += 1;
        text = "Mog the night hag is gone, defeated. The worldwine smuggling and distribution operation has been entirely disrupted. No more can be made. All that's left is to decide what to do with the worldwine that remains.";
        text += PARA + "Mog planned to dump it all in the city's water source. Doing so could cause a lot of problems for the devils who help rule the city... The substance is also quite valuable... you could always try to make a profit. Or, you could turn it over to someone -- law enforcement would be happy to take it off the streets, or the revolutionary elements in the city could make good use of it. Perhaps it should just be destroyed.";
    }

    if(GetLocalInt(oModule, "ddf_choice_made") == TRUE)
    {
        bFinished = TRUE;
        iUpdated += 1;
        text += PARA + "The worldwine has been dealt with. The investigation is over.";
    }

    DoJournalUpdate(oPC, JOURNAL_CHOICE, text, iUpdated, 6900, bFinished);

}

