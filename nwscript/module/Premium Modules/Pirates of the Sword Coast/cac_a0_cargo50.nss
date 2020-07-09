//::///////////////////////////////////////////////
//:: cac_a0_cargo50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has convinced the Dockhands to load the
    Statue. The plot is now complete. Go back to the
    rose to get the next plot from Sundry.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

// Fade out and hold all PCs in the area
void FadeOutPCs();

// Fade in and release all PCs in the area
void FadeInPCs();

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oDockHand1 = GetObjectByTag("a0_dockhand1");
    object oDockHand2 = GetObjectByTag("a0_dockhand2");
    object oRahman = GetObjectByTag("a0_rahman");
    object oWP = GetWaypointByTag("WP_A0_STATSPWN");
    object oRPoint = GetWaypointByTag("WP_A0_RAHSPAWN");
    object oStatue = GetObjectByTag("A0_SEASTATUE");
    object oCrate1 = GetObjectByTag("a0_packingcrate1");
    object oCrate2 = GetObjectByTag("a0_packingcrate2");

    location lWP = GetLocation(oWP);
    location lRSpwan = GetLocation(oRPoint);
    int iEXP = GetJournalQuestExperience("a0_cargo");
    iEXP = ConvertPercent(iEXP, 0.30f);

    HandoutQuestXP(oPC, iEXP);
    SetLocalInt(oModule, "A0_CARGO", 50);
    AddJournalQuestEntry("a0_cargo", 50, oPC);

    SetLocalInt(GetModule(), "A0_CARGOPLOTDONE", TRUE);

    //move the statue
    AssignCommand(GetArea(oPC), FadeOutPCs());

    AssignCommand(oDockHand1, ActionForceMoveToObject(oStatue));
    AssignCommand(oDockHand2, ActionForceMoveToObject(oStatue));
    DestroyObject(oStatue, 3.0f);
    DestroyObject(oDockHand1, 3.0f);
    DestroyObject(oDockHand2, 3.0f);
    DestroyObject(oRahman, 3.0f);
    DestroyObject(oCrate1, 3.0f);
    DestroyObject(oCrate2, 3.0f);

    AssignCommand(GetArea(oPC), DelayCommand(4.0f, FadeInPCs()));

    CreateObject(OBJECT_TYPE_PLACEABLE, "a0_mysterystat", lWP);
    CreateObject(OBJECT_TYPE_CREATURE, "a0_rahman", lRSpwan);
}

void FadeOutPCs()
{
    object oCursor = GetFirstObjectInArea(OBJECT_SELF);

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        if (GetIsPC(oCursor) == TRUE)
        {
            AssignCommand(oCursor, ClearAllActions(TRUE));
            AssignCommand(oCursor, SetCommandable(FALSE, oCursor));
            FadeToBlack(oCursor);
        }
        oCursor = GetNextObjectInArea(OBJECT_SELF);
    }
}


void FadeInPCs()
{
    object oCursor = GetFirstObjectInArea(OBJECT_SELF);

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        if (GetIsPC(oCursor) == TRUE)
        {
            AssignCommand(oCursor, ClearAllActions(TRUE));
            AssignCommand(oCursor, SetCommandable(TRUE, oCursor));
            FadeFromBlack(oCursor);
        }
        oCursor = GetNextObjectInArea(OBJECT_SELF);
    }
}
