#include "ddf_util"
#include "x0_i0_partywide"

void UpdateCoranoJournal(object oPC)
{
    string text = "Something is wrong...";
    object oModule = GetModule();

    int iUpdated = 0;

    int bClose = FALSE;

    // Check to see if the investigation is complete



    if(GetLocalInt(oModule, "ddf_property_deed") == TRUE)
    {
        iUpdated += 1;
        text = "You have discovered that the Corano noble family owned the warehouse in which Quillian was forced to manufacture worldwine. Perhaps it was being used without their knowledge -- but it seems equally probable that they are somehow involved in the worldwine operation. Investigating that connection could tell you a lot about how worldwine is getting into the city.";
        text += PARA + "You know the family has a villa in the Teeth of Orisaw district.";
        TryToMakeAvailable(AREA_TEETH_OF_ORISAW);
    }
    else if(GetLocalInt(oModule, "ddf_assassination_article_read") == TRUE)
    {
        iUpdated += 2;
        text = "You have learned that the Corano noble family owned a lot of warehouses in the Sea Market, perhaps including the one Quillian was trapped in. If so, it seems possible that they are involved in the worldwine operation somehow. Investigating that connection could tell you a lot about how worldwine is getting into the city. ";
        text += PARA + "You know the family has a villa in the Teeth of Orisaw district.";
        TryToMakeAvailable(AREA_TEETH_OF_ORISAW);
    }

    if(QuestActive(AREA_TEETH_OF_ORISAW) == TRUE)
    {
        if(GetLocalInt(oModule, "ddf_examined_spirit_letter") == TRUE || GetLocalInt(oModule, "ddf_examined_northmarket_property_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE)
        {
            SetQuestState(AREA_TEETH_OF_ORISAW, INVESTIGATION_COMPLETE);
        }

        if(GetLocalInt(oModule, "ddf_assassination_article_read") == TRUE || GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_INPROGRESS)
        {
            iUpdated += 4;
            text += PARA + "Many members of the Corano family have been assassinated. It's possible it has some connection to the worldwine operation. Either way, it might provide an opportunity to find out.";
        }

        if(GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_INPROGRESS)
        {
            iUpdated += 8;
            text += PARA + "The assassination of the Coranos has caused quite a commotion around their villa. If you're to learn anything, you'll have to find a way inside -- hopefully without being caught in places you're not supposed to be.";
        }

        if(GetLocalInt(oModule, "ddf_examined_spirit_letter") == TRUE)
        {
            iUpdated += 16;
            text += PARA + "Apparently the Coranos --  Farasano Corano in particular -- employed the services of a spiritual advisor named Aladara. There may be a connection here to worldwine, based on the notes. You should be able to track down the location of her apartment from the information you found to investigate further. ";
            if(GetLocalInt(oModule, "ddf_teddy_aladara") == TRUE)
            {
                iUpdated += 32;
                text += PARA + "Teddy seems to work for Aladara. ";
            }
        }
        else if(GetLocalInt(oModule, "ddf_teddy_aladara") == TRUE)
        {
            iUpdated += 64;
            text += PARA + "Apparently the Coranos employed the services of a spiritual advisor named Aladara. ";
        }

        if(GetLocalInt(oModule, "ddf_examined_northmarket_property_deed") == TRUE)
        {
            iUpdated += 128;
            text += PARA + "You have the property deed of the spiritualist Aladara and could track her down to find out what she may know.";
        }

        if(GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE)
        {
            iUpdated += 256;
            text += PARA + "The Coranos seem to own several warehouses in the Sea Market -- including one rented to a slaver named Ulan Aurintar, from whom Farasano Corano has purchased many slaves with a comment on their quality \"post-recovery.\" It's possible Ulan is also connected to the worldwine smuggling.";
        }

        if(GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_COMPLETE || GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_northmarket_property_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_spirit_letter") == TRUE )
        {
            bClose = TRUE;
            iUpdated += 512;
            text += PARA + "From what you can find, it seems possible that the Corano family is involved in the worldwine operation in some form. Most likely, one Farasano Corano -- among those who were assassinated -- may have been helping fund the operation. Now to track down his connections.";
        }
    }


    if(GetQuestWasActive(AREA_TEETH_OF_ORISAW) == TRUE && GetLocalInt(oModule, "DDF_CURRENT_DAY") > 3 && GetQuestState(AREA_TEETH_OF_ORISAW) != INVESTIGATION_COMPLETE)
    {
        bClose = TRUE;
        iUpdated = 1024;
        text += PARA + "You never investigated the Corano family at their villa, but there are more pressing things to investigate now. ";
    }

    DoJournalUpdate(oPC, JOURNAL_CORANO, text, iUpdated, 6400, bClose);

}

