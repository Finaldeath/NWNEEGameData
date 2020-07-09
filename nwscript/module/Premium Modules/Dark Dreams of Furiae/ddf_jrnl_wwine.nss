#include "ddf_util"
#include "x0_i0_partywide"

void UpdateWorldwineJournal(object oPC)
{
    string text = "Something is wrong...";
    object oModule = GetModule();

    int iUpdates = 0;

    int iTemp01 = FALSE;

    if(GetLocalInt(oModule, "dlg_quill_001_done") == TRUE)
    {
        iUpdates += 1;
        text = "An illicit arcane substance called \"worldwine\" has been on the streets of the city for a few months. No one knows where it comes from or how it gets into the city, but its distribution has only grown over time, even as the law has attempted to stamp down on it.";
        text += PARA + "Now, one piece of the puzzle has fallen into your lap -- whatever your motivation, it could be very worthwhile to look into the operation and do something about it.";
    }
    else
    {
        return; // Do not open until this has happened.
    }

    if(GetLocalInt(oModule, "ddf_quill_002_done") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Quillian the alchemist was apparently in charge of synthesizing worldwine from raw materials he was given, though he did so against his will. Quillian doesn't know much about the rest of the operation. ";
    }


    if(GetLocalInt(oModule, "ddf_teddy_quil_002") == TRUE)
    {
        iUpdates += 1;
        iTemp01 = TRUE;
        text += PARA + "A halfling named Teddy has some connection to worldwine as he was the courier for the ingredients, delivering them to Quillian at the warehouse.";
    }

    if(GetLocalInt(oModule, "ddf_tedd_smar") == TRUE)
    {
        iUpdates += 1;
        iTemp01 = TRUE;
        text += PARA + "You met the very nervous halfling in the Sea Market; however, he didn't stick around long enough to ask too much of him. He seemed genuinely concerned that someone may have been in the warehouse.";
    }


    if(iTemp01 != TRUE && (GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_INPROGRESS || GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_COMPLETE))
    {
        iUpdates += 1;
        text += PARA + "A halfling called Teddy was seen near the Corano villa.";
    }

    if(GetLocalInt(oModule, "ddf_teddy_aladara") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Teddy seems to work for a woman named Aladara. He doesn't seem to know anything about worldwine, however.";
    }

    if(GetLocalInt(oModule, "ddf_teddy_dead") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Teddy is now dead; he won't be of any more use.";
    }

    if(GetLocalInt(oModule, "ddf_property_deed") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "The Corano noble family owns the warehouse that Quillian manufactured worldwine in. They may be involved, somehow. ";
    }

    if(GetLocalInt(oModule, "ddf_property_deed") == FALSE && GetLocalInt(oModule, "ddf_assassination_article_read") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "The Corano noble family owns a lot of the warehouses in the Sea Market. It's very possible they owned the one Quillian manufactured worldwine in. They may be involved, somehow.";
    }


    if(GetLocalInt(oModule, "ddf_assassination_article_read") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Many of the Coranos have been assassinated, however. Is it connected to the worldwine trade? ";
    }

    if(GetQuestState(AREA_TEETH_OF_ORISAW) == INVESTIGATION_COMPLETE)
    {
        iUpdates += 1;
        text += PARA + "Indeed, it seems that Farasano Corano has been somehow funding the worldwine operation, with connections to multiple pieces of the puzzle.";
    }

    if(GetLocalInt(oModule, "ddf_learn_harasi_day2") == TRUE || GetLocalInt(oModule, "ddf_learn_harasi_dealers") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "A woman named Harasi seems to be intimately involved in the worldwine operation, possibly distributing the substance to street-level dealers.";
        TryUnlockHarasisSmallApartment();
    }

    if(GetLocalInt(oModule, "ddf_examined_harasi_documents") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Harasi doesn't know much about how worldwine gets into the city or is made, being mostly in charge of street-level operations. However she seems to be as interested in figuring it all out as you are -- if for more nefarious purposes. She's clearly ambitious.";
    }

    int iTemp02 = FALSE;

    if(GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE)
    {
        iUpdates += 1;
        iTemp02 = TRUE;
        text += PARA + "With Quillian out of the picture, Harasi has had to deal directly with Aladara to obtain worldwine for distribution -- though they seem concerned about what to do without the alchemist.";
    }

    if(GetLocalInt(oModule, "ddf_examined_grimy_ledger") == TRUE)
    {
        iUpdates += 1;
        iTemp02 = TRUE;
        text += PARA + "Ulan seems concerned that Harasi is making moves on the entire worldwine operation. ";
    }

    if(iTemp02 == TRUE)
    {
        iUpdates += 1;
        text += PARA + "She seems to run her end of the operation out of the Soul Trade Inn.";
    }

    if(GetLocalInt(oModule, "ddf_confront_harasi") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Harasi has been removed from the worldwine operation -- ";
        if(GetLocalInt(oModule, "ddf_harasi_dead") == TRUE)
        {
            iUpdates += 1;
            text += "she's dead, now. You killed her.";
        }
        if(GetLocalInt(oModule, "ddf_release_harasi") == TRUE)
        {
            iUpdates += 1;
            text += "you let her leave town with her life.";
        }
    }

    if(GetLocalInt(oModule, "ddf_letters_from_aladara") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Apparently the Coranos -- or Farasano Corano in particular -- employed the services of a spiritual advisor named Aladara. ";
    }
    else if(GetLocalInt(oModule, "ddf_teddy_aladara") == TRUE || iTemp02 == TRUE || GetLocalInt(oModule, "ddf_harasi_notes_read") == TRUE)
    {
        iUpdates += 3;
        text += PARA + "Apparently the Coranos employed the services of a spiritual advisor named Aladara.";
    }

    if(GetLocalInt(oModule, "ddf_ulan_aladara") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "With Farasano Corano dead, it seems Ulan has had to try to get his slaves to Aladara directly -- suggesting a connection between the slave trade and worldwine's production.";
    }

    if(GetQuestState(AREA_NORTH_MARKET) == INVESTIGATION_COMPLETE)
    {
        iUpdates += 1;
        text += PARA + "Indeed, it seems the ingredients for worldwine were smuggled into the city in the bodies of slaves, and extracted by Aladara in her basement. She also spoke of serving some kind of dark power -- is there something more behind the worldwine operation?";
    }

    if(GetLocalInt(oModule, "ddf_harasi_notes_read") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "From Harasi's observations, it seems that slaves were secretly brought to Aladara, who then produced the raw ingredients for worldwine to give to Quillian.";
    }

    if(GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE || GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE || GetLocalInt(oModule, "ddf_examined_harasi_documents") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Ulan Aurintar is a slaver that rents a Corano-owned warehouse in the Sea Market.";
    }

    if(GetLocalInt(oModule, "ddf_examined_south_market_deed") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Farasano Corano bought a lot of slaves from Ulan; references in the documentation suggest Ulan might be involved in the worldwine operation.";
    }

    if(GetLocalInt(oModule, "ddf_examined_harasi_documents") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "The dealer Harasi seems to think that his connections to the Corano family implicate him in the worldwine operation. ";
    }

    if(GetLocalInt(oModule, "ddf_examined_bloody_ledger") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Aladara originally gained access to the slaves carrying worldwine through the Coranos, but has since had to get them directly from Ulan, proving his involvement. Ulan appears to be the one bringing the raw worldwine materials into the city in the first place.";
    }

    if(GetLocalInt(oModule, "ddf_spoke_with_shavann") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Someone named Shavann is bringing additional slaves into the city through secret underground smuggling tunnels. After having given herself away, you may be able to track her down and find the heart of the operation. You've heard rumours there's even a connection to these tunnels through a cellar north of your apartment.";

        EnableMapPin("NW_MAPNOTE_009");
    }

    if(GetLocalInt(oModule, "ddf_killed_shavann") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "Indeed, Shavann was bringing additional slaves and worldwine into the city to help bolster the operation after so many of its operatives were removed from the picture; however, she too is now dead.";
    }

    if(GetLocalInt(oModule, "ddf_finished_nightmare_02") == TRUE)
    {
        iUpdates += 1;
        text += PARA + "There is a dark force at the heart of the worldwine operation, a powerful creature feeding on the dreams of its users. It apparently lurks deep beneath the city -- and is about to bring the whole operation crashing down on an unsuspecting populace. It must be confronted!";
    }

    int bFinished = FALSE;

    if(GetLocalInt(oModule, "ddf_karkualii_defeated") == TRUE)
    {
        bFinished = TRUE;
        iUpdates += 1;
        text += PARA + "The worldwine smuggling operation has been ended. The night hag that was secretly behind it all is gone, and most of her lieutenants are routed. The dreams of worldwine users will no longer be fed upon for darker purposes -- all that remains is to deal with the substance itself.";
    }

    DoJournalUpdate(oPC, JOURNAL_WORLDWINE, text, iUpdates, 6100, bFinished);

}


