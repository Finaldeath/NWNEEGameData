//::///////////////////////////////////////////////
//:: cac_a2_whipd20
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have agreed to help Willagin and there
    is a ladder near his manor.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    object oWPManor = GetWaypointByTag("a2_williganmanor");
    object oWPLadder = GetWaypointByTag("a2_willladder");
    int iEXP = GetJournalQuestExperience("a2_whipd");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_whipd20");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_whipd20", TRUE);

        // Hand out the required items XP and journal entries
        CreateObject(OBJECT_TYPE_PLACEABLE, "a2_wwladder", GetLocation(oWPLadder));

        SetMapPinEnabled(oWPLadder, TRUE);
        SetMapPinEnabled(oWPManor, TRUE);

        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A2_WHIPD", 20);
        AddJournalQuestEntry("a2_whipd", 20, oPC);
    }
}
