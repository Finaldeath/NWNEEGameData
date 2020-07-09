//::///////////////////////////////////////////////
//::
//:: con_bw_mirror_01
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Conversation script.
//::
//:: Take mirror, activate stand.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 10/29/2005
//::
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();

    string sItem = GetLocalString(OBJECT_SELF, "sItem");
    object oItem = GetItemPossessedBy(oPC, sItem);

    DestroyObject(oItem);

    PlaySound("it_metalbluntmed");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

    SetLocalInt(OBJECT_SELF, "nActivated", 1);
}
