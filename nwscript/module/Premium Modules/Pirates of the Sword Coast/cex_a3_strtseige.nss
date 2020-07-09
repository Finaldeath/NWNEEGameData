//::///////////////////////////////////////////////
//:: cex_a3_strtseige
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has begun the seige of the skull
    and bones by interacting with the ladder.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    object oModule = GetModule();

    int iDoOnce = GetLocalInt(oModule, "cex_a3_strtseige");

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "cex_a3_strtseige", TRUE);
        cs_StartCutscene_Poly("cut_a3_seige3", "", 0.0f, FALSE, FALSE, 10, oArea);
        DestroyObject(OBJECT_SELF, 5.0f);
    }
}
