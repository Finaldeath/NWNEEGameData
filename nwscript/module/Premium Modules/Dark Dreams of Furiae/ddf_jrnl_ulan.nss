#include "ddf_util"
#include "x0_i0_partywide"

// CUSTOM6600
// ddf_j_060
//
void UpdateUlanJournal(object oPC)
{
    string text = "";
    object oModule = GetModule();

    int iUpdated = 0;

    int bClosed = FALSE;


    if(GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE || GetLocalInt(oModule, "ddf_examined_harasi_documents") == TRUE )
    {
        iUpdated += 1;
        text = "A slaver named Ulan Aurintar has been connected to the worldwine operation. He runs his ring out of a warehouse in the Sea Market -- investigating there could reveal much about how worldwine gets into the city.";
        TryToMakeAvailable(AREA_ULANS_WAREHOUSE);

        EnableMapPin("NW_MAPNOTE001");
    }

    if(QuestActive(AREA_ULANS_WAREHOUSE) == TRUE)
    {
        if(GetIsItemPossessedByParty(oPC, "RING_ULAN") && GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE)
        {
            iUpdated += 2;
            SetQuestState(AREA_ULANS_WAREHOUSE, INVESTIGATION_COMPLETE);
            bClosed = TRUE;
        }

        if(GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE)
        {
            iUpdated += 4;
            text += PARA + "Farasano Corano has bought many of Ulan the slaver's \"products,\" and owns the slaver's warehouse. ";
        }
        if(GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE)
        {
            iUpdated += 8;
            text += PARA + "Ulan has begun to deliver slaves directly to Aladara now that Farasano Corano is dead. ";
        }

        if(GetLocalInt(oModule, "ddf_guarded_warehouse_knowledge") == TRUE)
        {
            iUpdated += 16;
            text += PARA + "Ulan's warehouse is very heavily guarded. You'll have to figure out a way to get inside. Folks in the area might know something you don't.";
        }
        if(GetLocalInt(oModule, "ddf_guarded_warehouse_secret_door") == TRUE)
        {
            iUpdated += 32;
            text += PARA + "Someone in the Sea Market has told you that there's a secret door in the back of the warehouse, through which Ulan sometimes moves his slaves. It may be a better way inside than through the front door.";
        }
        if(GetLocalInt(oModule, "ddf_entered_ulan_warehouse") == TRUE)
        {
            iUpdated += 64;
            text += PARA + "Having made it inside, the slavers here haven't given you any choice but to deal with them.";
        }
        if(GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE)
        {
            iUpdated += 128;
            text += PARA + "Ulan's notes make clear that someone named Harasi is beginning to make moves on the worldwine operation. She should be able to be found at the Soul Trade Inn.";
        }
        if(GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE)
        {
            iUpdated += 256;
            text += PARA + "Apparently, with the Coranos removed from the chain, Ulan has had to move his product directly to a woman named Aladara for \"processing.\" There's information locating her apartment.";
        }

        if(GetLocalInt(oModule, "ddf_deal_with_ulan") == TRUE || GetQuestState(AREA_ULANS_WAREHOUSE) == INVESTIGATION_COMPLETE)
        {
            iUpdated += 512;
            text += PARA + "Ulan and his slaving operation have been dealt with. ";
            if(GetLocalInt(oModule, "ddf_ulan_dead") == TRUE)
            {
                text += "Ulan is dead. ";
            }
            else
            {
                text += "You've let Ulan go with a harsh warning, and he's disappeared. ";
            }
            text += "He was smuggling raw worldwine materials into the city with his slaves; with him gone, the first link in the operation seems to have been severed. Now to deal with the rest of it.";
        }
    }


    if(GetQuestWasActive(AREA_ULANS_WAREHOUSE) == TRUE && GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE && GetLocalInt(oModule, "DDF_CURRENT_DAY") > 5)
    {
        bClosed = TRUE;
        iUpdated = 1024;
        text += PARA + "You never investigated Ulan directly, but there are more pressing things to investigate now.";
    }

    DoJournalUpdate(oPC, JOURNAL_ULAN, text, iUpdated, 6600, bClosed);

}

