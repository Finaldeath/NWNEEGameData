//::///////////////////////////////////////////////
//::
//:: con_bw_korin01
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Conversation script.
//::
//:: Take helm of dwarven lords.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/7/2005
//::
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    string sItem = GetLocalString(OBJECT_SELF, "sItem");
    object oItem = GetItemPossessedBy(oPC, sItem);

    DestroyObject(oItem);

    SetLocalInt(GetModule(), "nIH_HelmRestored", 1);
}
