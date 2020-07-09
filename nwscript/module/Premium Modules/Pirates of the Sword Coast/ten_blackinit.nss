//::///////////////////////////////////////////////
//:: ten_blackinit
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Initiate Dialog with the PC if he is not and enemy
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void FadeAreaPCs(object oArea);

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    int iEnemies = GetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY");
    int iDoOnce = GetLocalInt(GetModule(), "A0_BRBTRIG_D1");

    if (((GetIsPC(oPC) == TRUE) && (GetIsDM(oPC) == FALSE)) && (iEnemies == FALSE)
      && (iDoOnce == FALSE))
    {
        SetLocalInt(GetModule(), "A0_BRBTRIG_D1", TRUE);
        AssignCommand(oPC, ClearAllActions(TRUE));

        // Possessed Familiar protection
        if (GetIsPossessedFamiliar(oPC) == TRUE)
        {
            oPC = GetMaster(oPC);
        }

        SetLocalObject(oArea, "A0_BRB_Talker", oPC);

        cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM, oArea);
        cs_StartCutscene("cut_a0_brbencntr", "", 2.0f, FALSE, TRUE, 1, oArea);
    }
}

void FadeAreaPCs(object oArea)
{
    object oInArea = GetFirstObjectInArea(oArea);

    while (GetIsObjectValid(oInArea) == TRUE)
    {
        if (GetIsPC(oInArea) == TRUE)
        {
            SetCutsceneMode(oInArea, TRUE);
            FadeToBlack(oInArea);
        }

        oInArea = GetNextObjectInArea(oArea);
    }
}
