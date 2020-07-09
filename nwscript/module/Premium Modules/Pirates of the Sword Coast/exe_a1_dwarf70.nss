//::///////////////////////////////////////////////
//:: Name exe_a1_dwarf70
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Edgrim has gone hostile, update the plot.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "nw_i0_generic"

void CreateMonster(string sResRef, object oTarg);

void main()
{
    object oPC = GetFirstPC();
    object oEdgrimm = OBJECT_SELF;
    object oTarget1 = GetObjectByTag("a1_mnstrst", 0);
    object oTarget2 = GetObjectByTag("a1_mnstrst", 1);

    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);

    int iEXP = GetJournalQuestExperience("a1_dwarf");

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A1_DWARF", 70);
    AddJournalQuestEntry("a1_dwarf", 70, oPC);

    ChangeToStandardFaction(oEdgrimm, STANDARD_FACTION_HOSTILE);
    AssignCommand(oEdgrimm, PlayAnimation(ANIMATION_LOOPING_CONJURE1));
    AssignCommand(oEdgrimm, DetermineCombatRound(oPC));

    DelayCommand(1.0f, CreateMonster("a1_edgrimm_mnstr", oTarget1));
    DelayCommand(1.2f, CreateMonster("a1_edgrimm_mnstr", oTarget2));
    DelayCommand(1.4f, ApplyEffectToObject
        (DURATION_TYPE_TEMPORARY, eInvis, oEdgrimm, 20.0f));
}

void CreateMonster(string sResRef, object oTarg)
{
    effect eSpawn = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    location lSpawn = GetLocation(oTarg);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn);
    CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpawn);
    DestroyObject(oTarg, 0.1);
}
