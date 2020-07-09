//::///////////////////////////////////////////////
//:: con_a1_wrstcs
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Player has neither the wood or the plans,
    but they have set both factions hostile.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oPlans = GetItemPossessedBy(oPC, "a1_raftplans");
    object oWood = GetItemPossessedBy(oPC, "a1_sacredwood");

    int iDwarf = GetLocalInt(GetModule(), "A1_DWARF");
    int iTrogPlot = GetLocalInt(GetModule(), "A1_NATIVES");

    int iResult = FALSE;

    // The player has both the raft and the plans.
    if ((GetIsObjectValid(oWood) == FALSE)
     && (GetIsObjectValid(oPlans) == FALSE)
     && (iDwarf >= 70) && (iTrogPlot >= 110))
    {
        iResult = TRUE;
    }

    return iResult;
}
