//::///////////////////////////////////////////////
//:: exe_a2_crewinc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Add another NPC to the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = OBJECT_SELF;
    object oModule = GetModule();

    int iEXP = GetJournalQuestExperience("a2_crew");
    int iCrewCount = GetLocalInt(oModule, "A2_CREWCOUNT");
    int iRosePlot = GetLocalInt(oModule, "A2_MIDROSE");
    int iSkllPlot = GetLocalInt(oModule, "A2_NECRO");

    // hand out XP and feedback for recruiting the 5 crewman.
    if (iCrewCount == 0)
    {
        SetLocalInt(oModule, "A2_CREW", 20);
        AddJournalQuestEntry("a2_crew", 20, oPC);
    }
    else if (iCrewCount == 1)
    {
        SetLocalInt(oModule, "A2_CREW", 30);
        AddJournalQuestEntry("a2_crew", 30, oPC);
    }
    else if (iCrewCount == 2)
    {
        SetLocalInt(oModule, "A2_CREW", 40);
        AddJournalQuestEntry("a2_crew", 40, oPC);
    }
    else if (iCrewCount == 3)
    {
        SetLocalInt(oModule, "A2_CREW", 50);
        AddJournalQuestEntry("a2_crew", 50, oPC);
    }
    else if (iCrewCount == 4)
    {
        SetLocalInt(oModule, "A2_CREW", 60);
        AddJournalQuestEntry("a2_crew", 60, oPC);

        if (iRosePlot < 30)
        {
            SetLocalInt(oModule, "A2_MIDROSE", 30);
            AddJournalQuestEntry("a2_midrose", 30, oPC);
        }

        if (iSkllPlot == 10)
        {
            SetLocalInt(oModule, "A2_NECRO", 20);
            AddJournalQuestEntry("a2_necro", 20, oPC);
        }
        else if (iSkllPlot == 20)
        {
            SetLocalInt(oModule, "A2_NECRO", 30);
            AddJournalQuestEntry("a2_necro", 30, oPC);
        }
    }

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A2_CREWCOUNT", (iCrewCount + 1));
}
