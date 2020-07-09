//::///////////////////////////////////////////////
//:: exe_a2_a3_jump
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Jump the players from Act 2 to Act 3.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_polymorphfix"
#include "inc_balance"

void main()
{
    object oModule = GetModule();
    object oCursor = OBJECT_INVALID;
    object oTarget = GetObjectByTag("A3_IODI_SPAWN");
    object oItem = OBJECT_INVALID;

    location lTarget = GetLocation(oTarget);
    int iEXP = GetJournalQuestExperience("a2_necro");
    int iPlotCheck;

    // Recalculate the global difficulty for the next act
    ReCalcGlobalDif();

    oCursor = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
        PLAYER_CHAR_IS_PC);

    // Update the current plot
    iEXP = ConvertPercent(iEXP, 0.70f);
    HandoutQuestXP(oCursor, iEXP);
    SetLocalInt(oModule, "A2_NECRO", 40);
    AddJournalQuestEntry("a2_necro", 40, oCursor);

    // lockdown unused plots.
    iPlotCheck = GetLocalInt(oModule, "A2_REDTIP");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_REDTIP", 50);
        AddJournalQuestEntry("a2_redtip", 50, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_SHAKEY");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_SHAKEY", 50);
        AddJournalQuestEntry("a2_shakey", 50, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_WHIPD");
    if ((iPlotCheck > 0) && (iPlotCheck < 50))
    {
        SetLocalInt(oModule, "A2_WHIPD", 60);
        AddJournalQuestEntry("a2_whipd", 60, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_WWCTLS");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_WWCTLS", 50);
        AddJournalQuestEntry("a2_wwctls", 50, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_WWGARB");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_WWGARB", 50);
        AddJournalQuestEntry("a2_wwgarb", 50, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_WWBOOT");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_WWBOOT", 50);
        AddJournalQuestEntry("a2_wwboot", 50, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_PEGLEG");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_PEGLEG", 50);
        AddJournalQuestEntry("a2_pegleg", 50, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_SWEET");
    if ((iPlotCheck > 0) && (iPlotCheck < 50))
    {
        SetLocalInt(oModule, "A2_SWEET", 60);
        AddJournalQuestEntry("a2_sweet", 60, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_VANTAB");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_VANTAB", 50);
        AddJournalQuestEntry("a2_vantab", 50, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_BLOODS");
    if ((iPlotCheck > 0) && (iPlotCheck < 30))
    {
        SetLocalInt(oModule, "A2_BLOODS", 40);
        AddJournalQuestEntry("a2_bloods", 40, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_BLACKR");
    if ((iPlotCheck > 0) && (iPlotCheck < 30))
    {
        SetLocalInt(oModule, "A2_BLACKR", 40);
        AddJournalQuestEntry("a2_blackr", 40, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_FRANC");
    if ((iPlotCheck > 0) && (iPlotCheck < 80))
    {
        SetLocalInt(oModule, "A2_FRANC", 90);
        AddJournalQuestEntry("a2_franc", 90, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_LANGER");
    if ((iPlotCheck > 0) && (iPlotCheck < 60))
    {
        SetLocalInt(oModule, "A2_LANGER", 80);
        AddJournalQuestEntry("a2_langer", 80, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_TTTST");
    if ((iPlotCheck > 0) && (iPlotCheck < 40))
    {
        SetLocalInt(oModule, "A2_TTTST", 60);
        AddJournalQuestEntry("a2_tttst", 60, oCursor);
    }

    iPlotCheck = GetLocalInt(oModule, "A2_TATTOO");
    if ((iPlotCheck > 0) && (iPlotCheck < 30))
    {
        SetLocalInt(oModule, "A2_TATTOO", 70);
        AddJournalQuestEntry("a2_tattoo", 70, oCursor);
    }

    // Clean up inventories and remove naughty effects
    oCursor = GetFirstPC();
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        RemovePolymorph(oCursor);

        // clean out the old items that we don't need
        oItem = GetItemPossessedBy(oCursor, "a2_umbrlntrobe");
        DestroyObject(oItem);

        // Dump all IOUs
        oItem = GetItemPossessedBy(oCursor, "a2_ioutatt");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_iou001");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_iou002");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_iou003");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_iou004");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_iou005");
        DestroyObject(oItem);

        // Dump all Maps
        oItem = GetItemPossessedBy(oCursor, "map_blkbrd");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "map_scepter");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map001");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map002");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map003");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map004");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map005");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map006");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map007");
        DestroyObject(oItem);

        // Peices of Blackbeards map
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map009");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map010");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map011");
        DestroyObject(oItem);
        oItem = GetItemPossessedBy(oCursor, "trs_u_sys_map012");
        DestroyObject(oItem);

        oCursor = GetNextPC();
    }

    // Jump all players to the third act.
    JumpPCsToLocation(lTarget, 2);
}
