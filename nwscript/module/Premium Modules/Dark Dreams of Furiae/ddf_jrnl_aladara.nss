#include "ddf_util"
#include "x0_i0_partywide"

void UpdateAladaraJournal(object oPC)
{
    string text = "";
    object oModule = GetModule();

    int iUpdated = 0;

    int bClose = FALSE;

    if(GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE  || GetLocalInt(oModule, "ddf_examined_northmarket_property_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_spirit_letter") == TRUE )
    {
        iUpdated += 1;
        text = "Someone named Aladara has been acting as a spiritual advisor for the Corano family, but seems to secretly be involved in the worldwine operation somehow. You have discovered where she lives; it would be worth looking into her to find out more.";
        TryToMakeAvailable(AREA_NORTH_MARKET);
    }

    if(QuestActive(AREA_NORTH_MARKET) == TRUE)
    {
        if(GetLocalInt(oModule, "ddf_aladara_dead") == TRUE && GetIsItemPossessedByParty(oPC, "RING_ALADARA") == TRUE && ( GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE ||  GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE  || GetLocalInt(oModule, "ddf_examined_northmarket_property_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE) )
        {
            SetQuestState(AREA_NORTH_MARKET, INVESTIGATION_COMPLETE);
            bClose = TRUE;
        }

        if(GetLocalInt(oModule, "ddf_teddy_aladara") == TRUE)
        {
            iUpdated += 2;
            text += PARA + "You suspect Teddy works for Aladara, suggesting the raw worldwine materials come from her.";
        }

        if(GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE)
        {
            iUpdated += 4;
            text += PARA + "With Farasano Corano dead, you figure Ulan has had to try to get his slaves to Aladara directly -- suggesting a connection between the slave trade and worldwine's production.";
        }

        if(GetLocalInt(oModule, "ddf_harasi_notes_read") == TRUE)
        {
            iUpdated += 8;
            text += PARA + "From Harasi's observations, slaves were likely secretly brought to Aladara, who then produced the raw ingredients for worldwine to give to Quillian.";
        }

        if(GetLocalInt(oModule, "ddf_visited_aladaras_apartment") == TRUE)
        {
            iUpdated += 16;
            text += PARA + "Aladara's apartment appears innocuous enough, but she's not here -- perhaps there is a basement. ";
        }
        if(GetLocalInt(oModule, "ddf_attempt_aladaras_basement") == TRUE)
        {
            iUpdated += 32;
            text += PARA + "The halfling Teddy won't let you into the basement to find Aladara; you'll have to find a way around him.";
        }

        if(GetLocalInt(oModule, "ddf_entered_chop_shop") == TRUE || GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_COMPLETE)
        {
            iUpdated += 64;
            text += PARA + "There is no doubt now that Aladara is involved in the worldwine operation; there is a secret chamber in her basement where she performs surgery on slaves! ";
        }

        if(GetLocalInt(oModule, "ddf_talked_to_slaves") == TRUE)
        {
            iUpdated += 128;
            text += PARA + "From what you can tell, the raw materials to make worldwine are being smuggled into the city in the bodies of slaves. Aladara was then in charge of extracting the raw materials to deliver to Quillian for synthesis. A dark affair.";
        }

        if(GetLocalInt(oModule, "ddf_aladara_dead") == TRUE || GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_COMPLETE)
        {
            iUpdated += 256;
            text += PARA + "Aladara is dead now, after having tried to kill you for your incursion. Based on her pronouncements, she believes she serves some greater, darker power -- your suspicion that there is more to the worldwine operation grows. Regardless, a key part of the operation has been taken down.";
        }
    }

    // Only if this quest was active at some point should it be closed.
    if(GetQuestWasActive(AREA_NORTH_MARKET) == TRUE && GetQuestState(AREA_NORTH_MARKET) != INVESTIGATION_COMPLETE && GetCurrentDay() > 5)
    {
        bClose = TRUE;
        iUpdated = 512;
        text += PARA + "You never investigated Aladara directly, but there are more pressing things to investigate now. ";
    }

    DoJournalUpdate(oPC, JOURNAL_ALADARA, text, iUpdated,  6500, bClose);

}

