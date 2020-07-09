//::///////////////////////////////////////////////
//:: cac_a3_dead30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Captain Kolmar has entered the portal to the
    mysterious temple, but something seems amise.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

void PlayVFX (object oKolmarr);

void main()
{
    object oKolmarr = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oModule = GetModule();

    object oDoor = GetObjectByTag("a3_deaddoor");
    object oTargetA = GetWaypointByTag("A3_KOLMARR_02");
    object oTargetB = GetWaypointByTag("A3_NECROFIGHT0");

    int iEXP = GetJournalQuestExperience("a3_hunt");
    location lTarg = GetLocation(oTargetB);
    effect eVFX = EffectVisualEffect(VFX_IMP_DISPEL_DISJUNCTION);
    effect eGhost = EffectCutsceneGhost();

    //HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A3_DEAD", 30);
    AddJournalQuestEntry("a3_dead", 30, oPC);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oKolmarr);
    AssignCommand(oKolmarr, SetLocalInt(oKolmarr, "NO_TALKIE", TRUE));
    AssignCommand(oKolmarr, ActionCastFakeSpellAtObject(SPELL_KNOCK, oDoor));

    DelayCommand(2.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oDoor));
    DelayCommand(2.5f, AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 0.75)));
    DelayCommand(3.5f, SetLocalInt(oDoor, "OPEN_GATE", TRUE));

    AssignCommand(oKolmarr, ActionMoveToObject(oTargetA));
    AssignCommand(oKolmarr, ActionDoCommand(PlayVFX(oKolmarr)));
}

void PlayVFX (object oKolmarr)
{
    effect eVFX = EffectVisualEffect(VFX_FNF_DISPEL_GREATER);
    location lTarg = GetLocation(oKolmarr);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lTarg);
    DestroyObject(oKolmarr);
}
