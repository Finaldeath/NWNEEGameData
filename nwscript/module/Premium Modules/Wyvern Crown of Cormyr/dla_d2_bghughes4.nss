////////////////////////////////////////////////////////////////////////////////
// dla_d2_bghughes4
//
// DLA, Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Conversation conditional script that always returns TRUE.  The true
    purpose of this script is to set 3 custom tokens.
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
    string s2311 = "";
    string s2312 = "";
    string s2313 = "";
    object oPC = GetPCSpeaker();
    if (!GetLocalInt(oPC, "bNameChecked"))
        s2311 = "[Has not been checked]";
    if (!GetLocalInt(oPC, "bLevelChecked"))
        s2312 = "[Has not been checked]";
    if (!GetLocalInt(oPC, "bDeityChecked"))
        s2313 = "[Has not been checked]";

    SetCustomToken(2311, s2311);
    SetCustomToken(2312, s2312);
    SetCustomToken(2313, s2313);
    return TRUE;
}
