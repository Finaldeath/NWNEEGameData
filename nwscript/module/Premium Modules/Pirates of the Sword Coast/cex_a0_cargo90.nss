//::///////////////////////////////////////////////
//:: cex_a0_cargo90
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The plot is resolved. Rahmna has received and
    now levitates the statue into the box.
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
    object oRahman = GetObjectByTag("a0_rahman");
    object oWP = GetWaypointByTag("WP_A0_STATSPWN");
    object oRPoint = GetWaypointByTag("WP_A0_RAHSPAWN");
    object oStatue = GetObjectByTag("A0_SEASTATUE");

    location lWP = GetLocation(oWP);
    location lRSpwan = GetLocation(oRPoint);
    int iPlot = GetLocalInt(oModule, "A0_CARGO");
    int iDoOnce = GetLocalInt(oModule, "cex_a0_cargo90");

    if ((iPlot == 90) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "cex_a0_cargo90", TRUE);

        // teleport the statue
        AssignCommand(GetArea(oRahman), FadeOutPCs());

        AssignCommand(oRahman, ActionCastFakeSpellAtObject(SPELL_MAGE_ARMOR, oStatue));
        DestroyObject(oStatue, 2.0f);
        DestroyObject(oRahman, 2.0f);

        AssignCommand(GetArea(oRahman), DelayCommand(2.5f, FadeInPCs()));

        CreateObject(OBJECT_TYPE_PLACEABLE, "a0_mysterystat", lWP);
        CreateObject(OBJECT_TYPE_CREATURE, "a0_rahman", lRSpwan);
    }
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
