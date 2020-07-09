//::///////////////////////////////////////////////
//:: cac_a1_native90
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The King of the troglodyte army takes your
    winning against garm as a sign. he promises to
    help you if you kill edgrimm.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetObjectByTag("a1_jungle");
    object oModule = GetModule();
    object oWP_Trog = GetObjectByTag("a1_trogent");
    object oWP_Monst = GetObjectByTag("a1_mystcave");

    int iEXP = GetJournalQuestExperience("a1_natives");
    int iDoOnce = GetLocalInt(oArea, "cac_a1_native90");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oArea, "cac_a1_native90", TRUE);

        SetMapPinEnabled(oWP_Trog, TRUE);
        SetMapPinEnabled(oWP_Monst, TRUE);
        ExploreAreaForPlayer(oArea, oPC);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A1_NATIVES", 90);
        AddJournalQuestEntry("a1_natives", 90, oPC);

        if (GetLocalInt(oModule, "A1_DWARF") < 20)
        {
            //HandoutQuestXP(oPC, iEXPb);
            SetLocalInt(oModule, "A1_DWARF", 20);
            AddJournalQuestEntry("a1_dwarf", 20, oPC);
        }
    }
}
