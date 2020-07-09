//
// Investigate Distribution at Rooster's Roost
//
// ddf_j_010
// <CUSTOM61000>
//
// AREA_ROOSTERS_ROOST

#include "ddf_util"
#include "x0_i0_partywide"

void UpdateDistributionJournal(object oPC)
{
    int iCustom = 61000;
    int iRequiredClues = 3;

    string text = "";
    object oModule = GetModule();

    int iUpdated = 0;
    int bFinished = FALSE;


    if(GetLocalInt(oModule, "ddf_examined_bottle_worldwine") == TRUE || GetLocalInt(oModule, "ddf_spoke_dealer_02") == TRUE || GetLocalInt(oModule, "ddf_learn_harasi_day2") == TRUE)
    {
        iUpdated += 1;
        text = "You've determined that a tavern called Rooster's Roost in the North Market district may be intimately connected to worldwine use and distribution. The Roost is a den of shady activity, barely-legal pit fighting, and other vices. If anyone would know more about the distribution network and origins of worldwine, it may well be there.";
        TryToMakeAvailable(AREA_ROOSTERS_ROOST);
    }

    if(QuestActive(AREA_ROOSTERS_ROOST) == TRUE)
    {

        if(GetLocalInt(oModule, "ddf_visited_roosters_roost") == TRUE )
        {
            iUpdated += 2;
            text += PARA + "There's definitely a lot going on in this tavern and inn; you don't doubt there's many different flavors of illegal or immoral activity here. You'll need to figure out who to talk to, but they're likely to be suspicious of a fresh face. Maybe asking around will give you enough information to make a move.";
        }

        //if(GetLocalInt(oModule, "ddf_visited_roosters_roost") == TRUE )
        if(GetLocalInt(oModule, "ddf_rooster_clue_count") >= 1)
        {
            iUpdated += 4;
            text += PARA + "A woman named Kyla seems likely to be a worldwine dealer who may know a lot more about the operation. Whether she'll talk to you is a different story.";
        }

        if(GetLocalInt(oModule, "ddf_meet_kyla") == TRUE && GetLocalInt(oModule, "ddf_rooster_clue_count") < iRequiredClues )
        {
            iUpdated += 8;
            text += PARA + "The worldwine dealer Kyla is being cagey around you. You'll need to gather information about her and the operation if you want to ingratiate yourself to, or blackmail, her.";
        }

        if(GetLocalInt(oModule, "ddf_rooster_clue_count") >= iRequiredClues)
        {
            iUpdated += 16;
            text += PARA + "You think you have enough to get Kyla talking now.";
        }
        if(GetLocalInt(oModule, "ddf_learn_harasi_dealers") == TRUE && GetCurrentDay() >= 3 )
        {
            iUpdated += 32;
            text += PARA + "The dealer Kyla has told you of a woman named Harasi Finas, who is connected to the distribution network -- Kyla gets some of her supply directly from her, and believes she is much more connected than she seems. She keeps a room at the Rooster's Roost, which may have all the information you need.";
            TryUnlockHarasisSmallApartment();
            EnableMapPin("NW_MAPNOTE_018");
        }
        if(GetLocalInt(oModule, "ddf_visited_harasi_day3") == TRUE )
        {
            iUpdated += 64;
            text += PARA + "You've found an apartment Harasi keeps, though she is not here. There are a lot of notes, though.";
        }
        if(GetLocalInt(oModule, "ddf_examined_harasi_documents") == TRUE )
        {
            iUpdated += 128;
            text += PARA + "Though apparently involved in worldwine distribution, Harasi seems to be trying to figure out how the operation works as whole. She's determined that the Corano family owned the warehouse Quillian blew up and are most likely funding much of the operation; they also purchase an extremely large number of slaves from a slaver named Ulan Aurintar. According to her notes, Harasi thinks this slaver would be a good next step in her own investigation; you agree. He has a warehouse in the Sea Market.";
            bFinished = TRUE;
            SetQuestState(AREA_ROOSTERS_ROOST, INVESTIGATION_COMPLETE);
        }

    }

    if(GetQuestWasActive(AREA_ROOSTERS_ROOST) == TRUE && GetQuestState(AREA_ROOSTERS_ROOST) != INVESTIGATION_COMPLETE && GetLocalInt(oModule, "DDF_CURRENT_DAY") > 3)
    {
        bFinished = TRUE;
        iUpdated = 256;
        text += PARA + "You never investigated the Rooster's Roost, but there are more pressing things to investigate now. ";

    }

    DoJournalUpdate(oPC, JOURNAL_DISTRIBUTION, text, iUpdated,  iCustom, bFinished);

}

