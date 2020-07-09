//::///////////////////////////////////////////////
//:: cac_a1_gvchisel
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Give Edgrimm the Chisel object from ww1.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oChisel = GetItemPossessedBy(oPC, "ww1_chisel");
    int iDoOnce = GetLocalInt(GetModule(), "cac_a1_gvchisel");

    if (iDoOnce ==  FALSE)
    {
        SetLocalInt(GetModule(), "cac_a1_gvchisel", TRUE);
        DestroyObject(oChisel);
        HandoutQuestXP(oPC, 200);
    }
}
