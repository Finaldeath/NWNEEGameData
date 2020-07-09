//::///////////////////////////////////////////////
//:: cac_ip_esccombt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has attempted to escape dialog with the
    thugs in the golden apple. Everything now goes
    hostile.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "nw_i0_generic"

void main()
{
    object oPC = GetEnteringObject();
    object oThug1 = GetObjectByTag("a0_corridor_thug");
    object oThug2 = GetObjectByTag("a0_mutch");

    object oDoorThug1 = GetObjectByTag("a0_door_leader");
    object oDoorThug2 = GetObjectByTag("a0_door_bandit", 0);
    object oDoorThug3 = GetObjectByTag("a0_door_bandit", 1);

    int iEXP = GetJournalQuestExperience("a0_escort");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_ESCORT", 30);
    AddJournalQuestEntry("a0_escort", 30, oPC);

    ChangeToStandardFaction(oThug1, STANDARD_FACTION_HOSTILE);
    ChangeToStandardFaction(oThug2, STANDARD_FACTION_HOSTILE);

    DelayCommand(3.5f, AssignCommand(oThug1, DetermineCombatRound(oPC)));
    DelayCommand(4.0f,  AssignCommand(oThug1, SpeakString
        ("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK)));

    ChangeToStandardFaction(oDoorThug1, STANDARD_FACTION_HOSTILE);
    ChangeToStandardFaction(oDoorThug2, STANDARD_FACTION_HOSTILE);
    ChangeToStandardFaction(oDoorThug3, STANDARD_FACTION_HOSTILE);
}
