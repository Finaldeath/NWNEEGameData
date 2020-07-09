//::///////////////////////////////////////////////
//:: cac_a1_native30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has read the map. He/She now knows that
    there is a strange cave to the east, and a path
    to a troglodyte encampment on the west of the
    island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    object oModule = GetModule();
    object oWP_Trog = GetObjectByTag("a1_trogent");
    object oWP_Monst = GetObjectByTag("a1_mystcave");

    int iEXPa = GetJournalQuestExperience("a1_natives");
    int iEXPb = GetJournalQuestExperience("a1_dwarf");
    int iPlot;

    SetMapPinEnabled(oWP_Trog, TRUE);
    SetMapPinEnabled(oWP_Monst, TRUE);
    ExploreAreaForPlayer(oArea, oPC);

    if (GetLocalInt(oModule, "A1_NATIVES") < 30)
    {
        //HandoutQuestXP(oPC, iEXPa);
        SetLocalInt(oModule, "A1_NATIVES", 30);
        AddJournalQuestEntry("a1_natives", 30, oPC);
    }

    if (GetLocalInt(oModule, "A1_DWARF") < 10)
    {
        //HandoutQuestXP(oPC, iEXPb);
        SetLocalInt(oModule, "A1_DWARF", 10);
        AddJournalQuestEntry("a1_dwarf", 10, oPC);
    }
}
