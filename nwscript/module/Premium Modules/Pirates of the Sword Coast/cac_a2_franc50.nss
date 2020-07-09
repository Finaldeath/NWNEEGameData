//::///////////////////////////////////////////////
//:: cac_a2_franc50
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    After Failing to trick Pete out of the Ring
    Pete has attacked the PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "nw_i0_generic"
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oPete = OBJECT_SELF;
    object oModule = GetModule();
    object oRing = OBJECT_INVALID;
    int iEXP = GetJournalQuestExperience("a2_franc");
    int iDoOnce = GetLocalInt(oModule, "cac_a2_franc50");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_franc50", TRUE);
        SetLocalObject(oModule, "PETE_PC_TARGET", oPC);

        ChangeToStandardFaction(oPete, STANDARD_FACTION_HOSTILE);
        DelayCommand(1.0f, AssignCommand(oPete, DetermineCombatRound(oPC)));

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_FRANC", 50);
        AddJournalQuestEntry("a2_franc", 50, oPC);
    }
}
