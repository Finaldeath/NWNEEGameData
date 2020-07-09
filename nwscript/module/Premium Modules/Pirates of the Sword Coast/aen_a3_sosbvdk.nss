//::///////////////////////////////////////////////
//:: aen_a3_sosbvdk
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has reached gone top side and found
    the Midnight rose.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "_inc_experience"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_spndrf");
    iEXP = ConvertPercent(iEXP, 0.20f);

    object oWPCrew, oNPCCrew;

    int iDoOnce = GetLocalInt(oModule, "aen_a3_sosbvdk");
    int iCounter = 1;

    string sNPCTag;
    location lSpawn;

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "aen_a3_sosbvdk", TRUE);

        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_SPNDRF", 90);
        AddJournalQuestEntry("a2_spndrf", 90, oPC);

        UpdateSafePoint();
        sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));

        while (sNPCTag != "")
        {
            oWPCrew = GetObjectByTag("A3_ABVDECK_SPWN_0" + IntToString(iCounter));
            lSpawn = GetLocation(oWPCrew);

            sNPCTag = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter));
            oNPCCrew = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag, lSpawn);

            //SendMessageToPC(oPC, "***aen_a3_sbseige fired; crew '"
            //    + GetTag(oNPCCrew) + "' at waypoint '" + GetTag(oWPCrew) + "'");

            iCounter++;
        }

        ExecuteScript("exe_a3_water10", oPC);

        DelayCommand(1.0f, ExecuteScript("exe_autosave", GetModule()));
    }

    if (iDoOnce == FALSE)
    {
    }

}
