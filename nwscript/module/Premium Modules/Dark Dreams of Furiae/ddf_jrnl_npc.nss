#include "ddf_util"
#include "x0_i0_partywide"

void UpdateNpcJournal(object oPC)
{
    string text = "";
    object oModule = GetModule();

    int FINISH_IDX = 4;
    int iUpdated = 0;

    int bClose = FALSE;

    // FORVOR
    int iStoryIndex = GetLocalInt(oModule, "forvor_story_index");

    if(iStoryIndex > 0)
    {
        text = "The proprietor of Forvor's Favors started telling you a story about his youth. Return on subsequent days to hear more.";
        iUpdated = 1;
        bClose = FALSE;
    }
    if(iStoryIndex == FINISH_IDX)
    {

        text += PARA + "Forvor has finished telling you the tale of his youth, and you feel you understand him better for it.";
        iUpdated = 2;
        bClose = TRUE;
    }
    if(iUpdated > 0) DoJournalUpdate(oPC, JOURNAL_FORVOR, text, iUpdated, JOURNAL_FORVOR_IDX, bClose);


    // LUICIL
    iUpdated = 0;
    iStoryIndex = GetLocalInt(oModule, "luicil_story_index");

    if(iStoryIndex > 0)
    {
        text = "The bard Luicil started telling you the story of how he and Forvor first met. Return on subsequent days to hear more.";
        iUpdated = 1;
        bClose = FALSE;
    }

    if(iStoryIndex == FINISH_IDX)
    {
        text += PARA + "Luicil has finished telling you his stories about him and Forvor, and you understand their relationship a little better because of it.";
        iUpdated = 2;
        bClose = TRUE;
    }

    if(iUpdated > 0) DoJournalUpdate(oPC, JOURNAL_LUICIL, text, iUpdated, JOURNAL_LUICIL_IDX, bClose);


    // KRESH
    iUpdated = 0;
    iStoryIndex = GetLocalInt(oModule, "kresh_story_index");

    if(iStoryIndex > 0)
    {
        text = "You've struck up conversation with the fishmonger Kresh, and you think he'd be willing to open up more in time. Return on subsequent days to hear more.";
        iUpdated = 1;
        bClose = FALSE;
    }

    if(iStoryIndex == FINISH_IDX)
    {
        text += PARA + "Kresh has run out of stories for you, but you feel you know him -- and his anti-slavery attitude -- a lot better now.";
        iUpdated = 2;
        bClose = TRUE;
    }

    DoJournalUpdate(oPC, JOURNAL_KRESH, text, iUpdated, JOURNAL_KRESH_IDX, bClose);

    // TAG
    iUpdated = 0;
    iStoryIndex = GetLocalInt(oModule, "tag_story_index");

    if(iStoryIndex > 0)
    {
        text = "You've made conversation with a man named Tag in your neighborhood. Return on subsequent days to continue the conversation.";
        iUpdated = 1;
        bClose = FALSE;
    }

    if(iStoryIndex == FINISH_IDX)
    {
        text += PARA + "You've heard a lot from Tag over the last few days. There won't be time for more conversation now, but you feel you've gained a good perspective from him.";
        iUpdated = 2;
        bClose = TRUE;
    }

    if(iUpdated > 0) DoJournalUpdate(oPC, JOURNAL_TAG, text, iUpdated, JOURNAL_TAG_IDX, bClose);

    // COCHRANE
    iUpdated = 0;
    iStoryIndex = GetLocalInt(oModule, "cochrane_story_index");

    if(iStoryIndex > 0)
    {
        text = "The naval captain Cochrane has drunkenly opened up to you a little. Return on subsequent days to hear more.";
        iUpdated = 1;
        bClose = FALSE;
    }

    if(iStoryIndex == FINISH_IDX)
    {
        text += PARA + "You're not sure what will happen to Cochrane in the next little while, but you feel you've gained a lot of insight into her plight this week.";
        iUpdated = 2;
        bClose = TRUE;
    }

    if(iUpdated > 0) DoJournalUpdate(oPC, JOURNAL_COCHRANE, text, iUpdated, JOURNAL_COCHRANE_IDX, bClose);



}

