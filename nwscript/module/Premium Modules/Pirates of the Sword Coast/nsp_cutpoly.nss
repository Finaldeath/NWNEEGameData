//::///////////////////////////////////////////////
//:: nsp_cutpoly
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sets Poly to a bat appearance, if the
    variable is set.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: May 5, 2005
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iUndead = GetLocalInt(oModule, "exe_a3_dead40") &&
                  (GetLocalInt(oModule, "A3_WATER")!=90);
    // If the player should be undead set poly to appear as a bat
    if (iUndead == TRUE)
    {
        SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_BAT);
    }
}
