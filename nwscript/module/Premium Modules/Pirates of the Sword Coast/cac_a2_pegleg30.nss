//::///////////////////////////////////////////////
//:: cac_a2_pegleg30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You've given Peg-Leg Paulson too much liquer.
    He's lost his stomach and fallen asleep.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oModule = GetModule();
    object oPegLeg = OBJECT_SELF;

    effect eSleep = EffectSleep();
    effect eVFX = EffectVisualEffect(VFX_IMP_SLEEP);

    int iEXP = GetJournalQuestExperience("a2_pegleg");

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_PEGLEG", 30);
    AddJournalQuestEntry("a2_pegleg", 30, oPC);

    eSleep = EffectLinkEffects(eVFX, eSleep);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oPegLeg, 30.0f);
    SetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK", 0);
}
