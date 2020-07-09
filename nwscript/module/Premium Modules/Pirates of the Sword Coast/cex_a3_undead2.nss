//::///////////////////////////////////////////////
//:: cex_a3_undead2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The conversation with Kolamrr ends and the
    Necromatic Pirate proceeds to make the
    player and crew into his undead servants.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    object oModule = GetModule();

    int iDoOnce = GetLocalInt(oModule, "cex_a3_undead2");

    if ((GetIsPC(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "cex_a3_undead2", TRUE);
        ExecuteScript("cut_a3_undead2", oArea);
    }
}
