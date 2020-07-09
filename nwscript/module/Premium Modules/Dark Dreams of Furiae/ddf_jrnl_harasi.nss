//
// Investigate Harasi the Dealer
//
// ddf_j_011
// <CUSTOM61100>
//
// AREA_SOUL_TRADE_INN
// JOURNAL_HARASI

#include "ddf_util"
#include "x0_i0_partywide"

void UpdateHarasiJournal(object oPC)
{
    int iCustom = 61100;

    string text = "";
    object oModule = GetModule();

    int iUpdated = 0;
    int bFinished = FALSE;

    //if(GetQuestState(AREA_SOUL_TRADE_INN) == INVESTIGATION_COMPLETE) return;


    if(GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE || GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE)
    {
        iUpdated += 1;
        text = "Harasi Finas is the woman in charge of the worldwine distribution network, tasked with taking finished materials from Quillian and selling them throughout the city. With much of the operation being shut down, she is making moves to bring it all under her control. She operates primarily out of the Soul Trade Inn -- tracking her down could go a long way to ending the operation altogether.";
        TryToMakeAvailable(AREA_SOUL_TRADE_INN);
    }

    if(QuestActive(AREA_SOUL_TRADE_INN) == TRUE)
    {
        if(GetLocalInt(oModule, "ddf_visited_soul_trade_inn") == TRUE)
        {
            iUpdated += 2;
            text += PARA + "You've arrived at the Soul Trade Inn. If Harasi has rooms here, you'll have to find a way to access them.";
        }
        if(GetLocalInt(oModule, "ddf_visited_soul_trade_inn_wing") == TRUE)
        {
            iUpdated += 4;
            text += PARA + "You have found a way to access the wing of the inn that Harasi is staying in. It looks like she may have hired some guards for this very eventuality.";
        }

        if(GetLocalInt(oModule, "ddf_confront_harasi") == TRUE)
        {
            iUpdated += 8;
            text += PARA + "You have confronted Harasi. ";

            if(GetLocalInt(oModule, "ddf_harasi_dead") == TRUE)
            {
                iUpdated += 16;
                text += "After a battle with her and her mercenaries, she lies dead. She will no longer be assisting the worldwine operation, and any notes she has are yours to explore.";
            }
            if(GetLocalInt(oModule, "ddf_release_harasi") == TRUE)
            {
                iUpdated += 32;
                text += "She has fled the inn with a promise to leave the city altogether. Whether you believe her or not, she will no longer be taking part in the worldwine operation, and any notes she has are yours to explore.";
            }

        }
        if(GetLocalInt(oModule, "ddf_harasi_notes_read") == TRUE)
        {
            iUpdated += 64;
            text += PARA + "It appears that Harasi was close to putting together all the pieces of the worldwine operation. Slaves were brought into the city by Ulan, bought by Farasano Corano, and delivered to Aladara to extract the hidden worldwine ingredients. These were delivered to Quillian, the alchemist, before Harasi picked up the finished substance for distribution. You can't shake the feeling that there is more to it all.";
        }

        if(GetLocalInt(oModule, "ddf_confront_harasi") == TRUE && (GetLocalInt(oModule, "ddf_harasi_dead") == TRUE || GetLocalInt(oModule, "ddf_release_harasi") == TRUE))
        {
            bFinished = TRUE;
            iUpdated += 128;
            SetQuestState(AREA_SOUL_TRADE_INN, INVESTIGATION_COMPLETE);
        }
    }

    if(GetQuestWasActive(AREA_SOUL_TRADE_INN) == TRUE && GetQuestState(AREA_SOUL_TRADE_INN) != INVESTIGATION_COMPLETE && GetLocalInt(oModule, "DDF_CURRENT_DAY") > 5)
    {
        bFinished = TRUE;
        iUpdated = 256;
        text += PARA + "You never investigated Harasi directly, but there are more pressing things to investigate now.";

    }

    DoJournalUpdate(oPC, JOURNAL_HARASI, text, iUpdated,  iCustom, bFinished);

}

