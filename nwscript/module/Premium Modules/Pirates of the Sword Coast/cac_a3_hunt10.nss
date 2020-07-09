//::///////////////////////////////////////////////
//:: cac_a3_hunt10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has gained the maps where the solutions
    to the maps have been buried. During the
    exchange

    Old Tom started to act strangely
    and gave the PC a strange amulet, saying
    something about "needing it more then the
    maps to survive this".
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oCursor = OBJECT_INVALID;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a3_hunt");
    iEXP = ConvertPercent(iEXP, 0.10f);
    int iDoOnce = GetLocalInt(oModule, "cac_a3_hunt10");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a3_hunt10", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A3_HUNT", 10);
        AddJournalQuestEntry("a3_hunt", 10, oPC);

        SetLocalInt(oModule, "A3_DEAD", 25);
        AddJournalQuestEntry("a3_dead", 25, oPC);

        //Create the one map and one sigil key on the PC Speaker
        CreateItemOnObject("trs_u_sys_iotd", oPC, 1);
        CreateItemOnObject("a3_sigilkey", oPC, 1);

        oCursor = GetFirstPC();
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            CreateItemOnObject("nw_it_sparscr315", oCursor, 1);
            CreateItemOnObject("nw_it_sparscr113", oCursor, 1);

            CreateItemOnObject("x2_it_spdvscr308", oCursor, 1);
            CreateItemOnObject("x2_it_spdvscr203", oCursor, 1);
            CreateItemOnObject("x2_it_spdvscr302", oCursor, 1);
            CreateItemOnObject("x1_it_spdvscr201", oCursor, 1);

            CreateItemOnObject("x1_wmgrenade005", oCursor, 5);
            CreateItemOnObject("NW_IT_MEDKIT002", oCursor, 5);
            CreateItemOnObject("a3_talisaman", oCursor, 1);

            oCursor = GetNextPC();
        }
    }
}
