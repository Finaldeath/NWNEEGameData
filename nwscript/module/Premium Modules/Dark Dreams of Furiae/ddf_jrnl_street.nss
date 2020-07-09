#include "ddf_util"

void UpdateStreetJournal(object oPC)
{
    string text = "Something is wrong...";
    object oModule = GetModule();

    int iUpdated = 0;
    int bFinished = FALSE;
    int bKnowRRH = FALSE;

    if(GetLocalInt(oModule, "dlg_quill_002_done") == TRUE)
    {
        iUpdated += 1;
        text = "A terrified gnome called Quillian has told you about his connection to the worldwine epidemic and his part in the destruction of the Sea Market warehouse where it was manufactured. Someone took the finished substance from him for distribution, after he created the worldwine. Finding people selling or using worldwine would be a good place to start learning more about the whole operation. ";
        text += PARA + "You can likely find such people in Rathole; the slums aren't as highly patrolled as the rest of the city, and the people living there have much to escape from through the use of worldwine...";
        TryToMakeAvailable(AREA_RATHOLE_STREETS);
    }

    if(QuestActive(AREA_RATHOLE_STREETS) == TRUE)
    {

        if(GetLocalInt(oModule, "ddf_spoke_dealer") == TRUE)
        {
            iUpdated += 2;
            text += PARA + "You've found someone who you think may sell worldwine, but getting any actually useful information out of them will be more difficult.";
        }

        if(GetLocalInt(oModule, "ddf_learn_dealers") == TRUE)
        {
            iUpdated += 4;
            text += PARA + "Having spoken to some folks who buy and use worldwine, you have a better sense of how the substance works -- and where they obtain it. This knowledge might help you get information out of the dealers on where they get their product.";
        }

        if(GetLocalInt(oModule, "ddf_spoke_dealer_02") == TRUE)
        {
            bKnowRRH = TRUE;
            iUpdated += 8;
            text += PARA + "One of the worldwine sellers has told you of a tavern called Rooster's Roost, apparently a hotbed of worldwine use and distribution. If anyone would know more about the distribution network and origins of worldwine, it would be there.";
        }

        if(GetLocalInt(oModule, "ddf_learn_harasi_day3") == TRUE)
        {
            bKnowRRH = TRUE;
            iUpdated += 16;
            text += PARA + "One of the worldwine sellers has told you of a woman named Harasi Finas, who is apparently connected to the distribution network -- she doesn't contact these street-level dealers directly, but has been seen in the area. The apartment she keeps nearby may have all the information you need.";
            TryUnlockHarasisSmallApartment();
            EnableMapPin("NW_MAPNOTE_015");

        }

        if(GetLocalInt(oModule, "ddf_examined_bottle_worldwine") == TRUE)
        {
            bKnowRRH = TRUE;
            iUpdated += 32;
            text += PARA + "You've obtained a bottle of worldwine. Wherever the substance itself came from, the *container* looks like a repurposed spirits bottle, from a tavern called Rooster's Roost. It could be a worthy avenue of investigation.";
        }
        if(GetLocalInt(oModule, "ddf_learn_harasi_day2") == TRUE)
        {
            bKnowRRH = TRUE;
            iUpdated += 64;
            text += PARA + "One of the folks you spoke to in Rathole mentioned a woman named Harasi. They seemed cagey about it, almost fearful; Harasi could be involved in the operation on a much higher level.";
        }

        if(bKnowRRH == FALSE && GetLocalInt(oModule, "ddf_dealers_dead") == TRUE)
        {
            iUpdated += 128;
            text += PARA + "Anyone that could help you in Rathole is now dead. You'll have to find a different avenue of investigation.";
            bFinished = TRUE;
            SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_COMPLETE);
        }


        if(GetLocalInt(oModule, "ddf_visited_harasi_day2") == TRUE)
        {
            iUpdated += 256;
            text += PARA + "You've found an apartment Harasi keeps, though she is not here. There are a lot of notes, though.";
        }
        if(GetLocalInt(oModule, "ddf_examined_harasi_documents") == TRUE)
        {
            iUpdated += 512;
            text += PARA + "Though apparently involved in worldwine distribution, Harasi seems to be trying to figure out how the operation works as a whole. She's determined that the Corano family owned the warehouse Quillian blew up and are most likely funding much of the operation; they also purchase an extremely large number of slaves from a slaver named Ulan Aurintar. According to her notes, Harasi thought this slaver would be a good next step in her own investigation; you agree. He has a warehouse in the Sea Market.";
        }

        //
        // CHECK FOR INVESTIGATION COMPLETE
        //

        if(bKnowRRH == TRUE && GetCurrentDay() == 2)
        {
            iUpdated += 1024;
            text += PARA + "You've learned that a tavern called Rooster's Roost may be intimately connected to worldwine use and distribution. If anyone would know more about the distribution network and origins of worldwine, it's there.";
            bFinished = TRUE;
            SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_COMPLETE);
        }

        if(GetLocalInt(oModule, "ddf_examined_harasi_documents") && GetCurrentDay() == 3)
        {
            iUpdated += 2048;
            text += PARA + "Though apparently involved in worldwine distribution, Harasi seems to be trying to figure out how the whole operation works as much as you are. She's determined that the Corano family owned the warehouse Quillian blew up and seems to be funding much of the operation; they also purchase an extremely large number of slaves from a slaver named Ulan Aurintar. She thought this slaver would be a good next step; you agree. He has a warehouse in the Sea Market.";
            bFinished = TRUE;
            SetQuestState(AREA_RATHOLE_STREETS, INVESTIGATION_COMPLETE);
        }
    }


    // do need to check for complete here, as the thing might have have become complete
    // ... although the day 3 check should removed that...
    // anyway.
    if(GetQuestWasActive(AREA_RATHOLE_STREETS) == TRUE && GetQuestState(AREA_RATHOLE_STREETS) != INVESTIGATION_COMPLETE && GetCurrentDay() > 3)
    {
        bFinished = TRUE;
        iUpdated = 4096;
        text += PARA + "You never investigated the street-level operations, but there are more pressing things to investigate now.";
    }

    DoJournalUpdate(oPC, JOURNAL_STREET, text, iUpdated, 6300, bFinished);

}

