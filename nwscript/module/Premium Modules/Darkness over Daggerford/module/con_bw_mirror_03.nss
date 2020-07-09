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
//:: Rotate mirror stand clockwise.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 10/29/2005
//::
//:://////////////////////////////////////////////

void main()
{
    PlaySound("as_sw_stoneop1");

    float fFacing = GetFacing(OBJECT_SELF);
    fFacing -= 90.0f;

    SetFacing(fFacing);
}
