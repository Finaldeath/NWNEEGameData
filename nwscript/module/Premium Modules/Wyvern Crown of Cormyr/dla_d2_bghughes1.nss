////////////////////////////////////////////////////////////////////////////////
// dla_d2_bghughes1
//
// DLA, Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Used in the conversation dla_cv_bgphughes (game master conversation) to
    determine if the player needs to be given information about chosing a proper
    name for the game.
 */
////////////////////////////////////////////////////////////////////////////////
// Created By: Syrsnein
// Created On: 12 June 2006
////////////////////////////////////////////////////////////////////////////////
/*
 Change history

 */

int StartingConditional()
{
    if (!GetLocalInt(GetPCSpeaker(), "bNameChecked")) return TRUE;
    return FALSE;
}