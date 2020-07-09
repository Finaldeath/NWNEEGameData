//::///////////////////////////////////////////////
//::
//:: con_bw_mirror_02
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: Conversation script.
//::
//:: Give mirror, deactivate stand.
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

    CreateItemOnObject(sItem, oPC);

    PlaySound("it_metalbluntmed");
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);

    SetLocalInt(OBJECT_SELF, "nActivated", 0);
}
