//::///////////////////////////////////////////////
//:: cac_a2_tasleave1
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start the cutscene where Tasina and her
    crew leave peacefully.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
//:: Modified By: Keith K2 Hayward
//:: Modified On: March 21/05
//:: Added a variable to track if the PC was kind
//:: or cruel to Tasina (Checked in Act 3).
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_global"

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    int iRosePlot = GetLocalInt(oModule, "A2_MIDROSE");
    int iSkllPlot = GetLocalInt(oModule, "A2_NECRO");
    int iEXP = GetJournalQuestExperience("a2_spndrf");
    iEXP = ConvertPercent(iEXP, 0.30f);

//// ADDED BY K2 - March 21/05 -----------------
    SetLocalInt(oModule, "POTSC_A2_TASINAFRIENDLY", TRUE);
    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_SPNDRF", 80);
    AddJournalQuestEntry("a2_spndrf", 80, oPC);

    SetLocalInt(oModule, "A2_MIDROSE", 40);
    AddJournalQuestEntry("a2_midrose", 40, oPC);

    if (iSkllPlot == 20)
    {
        SetLocalInt(oModule, "A2_NECRO", 30);
        AddJournalQuestEntry("a2_necro", 30, oPC);
    }
//// ADDED BY K2 - March 21/05 -----------------

    // this conversation is a part of the first cutscene, we now need to end it
    object oArea = GetArea(OBJECT_SELF);
    cs_ResetDelay(-1.0, 0.0, oArea, 1);
    // but before ending it, set a variable on the area so that the end
    // script knows that it should start another cutscene
    SetLocalInt(oArea, "nNextCutscene", 2); // 2 = tas2 cutscene
    cs_CameraDoFade(0.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST, oArea, 1);
    cs_EndCutscene(1.0, FALSE, FALSE, FADE_SPEED_MEDIUM, 1, oArea);

    // activate trigger, so it'll react to Tasina and the priestesses
    object oTrig = GetObjectByTag(a2t_temple_portal);
    SetLocalInt(oTrig, l_n_A2_TEMPLE_PORTAL_OUT_ACTIVE, TRUE);
}
