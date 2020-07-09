//::///////////////////////////////////////////////
//:: exe_a3_huntinc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has unlocked another portal
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();
    object oWP, oNPC;

    int iEXP = GetJournalQuestExperience("a3_hunt");
    iEXP = ConvertPercent(iEXP, 0.15f);
    int iPlot = GetLocalInt(oModule, "A3_HUNT");
    int iSpark = GetLocalInt(oModule, "A3_SPARKLE") + 1;

    string sGlowy = "A3_SPARK_SPWN" + IntToString(iSpark);
    string sNPCTag = GetLocalString(oModule, "NPC_CREW" + IntToString(iSpark));

    oWP = GetWaypointByTag(sGlowy);
    oNPC = GetObjectByTag(sNPCTag);

    AssignCommand(oPC, ClearAllActions(TRUE));

    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_sparkle", GetLocation(oWP));

    if (iSpark == 5)
    {
        oWP = GetWaypointByTag("A3_SPARK_SPWN5a");
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_solred", GetLocation(oWP));
        oWP = GetWaypointByTag("A3_SPARK_SPWN5b");
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_solred", GetLocation(oWP));
    }

    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_SPARKLE", iSpark);
    SetLocalInt(oModule, "A3_HUNT", iPlot + 10);
    AddJournalQuestEntry("a3_hunt", iPlot + 10, oPC);
}
