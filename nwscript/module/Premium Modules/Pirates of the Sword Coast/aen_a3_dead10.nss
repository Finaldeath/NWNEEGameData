//::///////////////////////////////////////////////
//:: aen_a3_dead10
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC and crew have arrived on the island of
    the Dead. You should find Kolmarr and talk
    about what to do next.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_balance"
#include "inc_safepoint"

void main()
{
    object oPC = GetEnteringObject();
    object oModule = GetModule();
    object oBelowDeck = GetObjectByTag("a3iodskllbns");
    object oNPC, oWayPoint;

    int iEXP = GetJournalQuestExperience("a3_dead");
    int iDoOnce = GetLocalInt(OBJECT_SELF, "aen_a3_dead10");
    int iCounter = 1;

    string sNPC;

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        UpdateSafePoint(oBelowDeck);

        SetLocalInt(OBJECT_SELF, "aen_a3_dead10", TRUE);
        //HandoutQuestXP(oPC, iEXP);

        SetLocalInt(oModule, "A3_DEAD", 10);
        AddJournalQuestEntry("a3_dead", 10, oPC);

        while (iCounter < 6)
        {
            sNPC = GetLocalString(oModule, "NPC_CREW" + IntToString(iCounter));
            oWayPoint = GetWaypointByTag("A3_SPAWN_" + sNPC);
            oNPC = CreateObject(OBJECT_TYPE_CREATURE, sNPC, GetLocation(oWayPoint));
            iCounter = iCounter + 1;
        }

        oNPC = GetObjectByTag("a2_hench_nisar");
        oWayPoint = GetWaypointByTag("A3_SPAWN_a2_hench_nisar");
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, JumpToObject(oWayPoint));

        oNPC = GetObjectByTag("a1_hench_garm");
        oWayPoint = GetWaypointByTag("A3_SPAWN_a1_hench_garm");
        AssignCommand(oNPC, ClearAllActions(TRUE));
        AssignCommand(oNPC, JumpToObject(oWayPoint));

        DelayCommand(1.0f, ExecuteScript("exe_autosave", GetModule()));
    }
}
