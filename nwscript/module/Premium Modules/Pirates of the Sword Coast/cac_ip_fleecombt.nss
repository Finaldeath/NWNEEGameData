//::///////////////////////////////////////////////
//:: cac_ip_fleecombt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has successfully disuaded the guards at
    Inn level of the golden apple. They will now
    flee.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "nw_i0_generic"

void main()
{
    object oModule = GetModule();
    object oPC = GetEnteringObject();
    object oDoor = GetObjectByTag("DOOR");
    object oThug1 = GetObjectByTag("a0_corridor_thug");
    object oThug2 = GetObjectByTag("a0_mutch");

    object oDoorThug1 = GetObjectByTag("a0_door_leader");
    object oDoorThug2 = GetObjectByTag("a0_door_bandit", 0);
    object oDoorThug3 = GetObjectByTag("a0_door_bandit", 1);

    int iEXP = GetJournalQuestExperience("a0_escort");
    effect eGhost = EffectCutsceneGhost();

    SetLocalInt(oModule, "DEAD_BANDITS", 2);

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_ESCORT", 30);
    AddJournalQuestEntry("a0_escort", 30, oPC);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oThug1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oThug2);
    AssignCommand(oThug1, ActionMoveToObject(oDoor, TRUE));
    AssignCommand(oThug2, ActionMoveToObject(oDoor, TRUE));
    DelayCommand(1.5,AssignCommand(oThug1, DestroyObject(oThug1)));
    DelayCommand(1.5,AssignCommand(oThug2, DestroyObject(oThug2)));

    DelayCommand(0.5, AssignCommand(oThug1, DetermineCombatRound(oPC)));
    DelayCommand(0.75,  AssignCommand(oThug1, SpeakString
        ("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK)));

    ChangeToStandardFaction(oDoorThug1, STANDARD_FACTION_HOSTILE);
    ChangeToStandardFaction(oDoorThug2, STANDARD_FACTION_HOSTILE);
    ChangeToStandardFaction(oDoorThug3, STANDARD_FACTION_HOSTILE);
}
