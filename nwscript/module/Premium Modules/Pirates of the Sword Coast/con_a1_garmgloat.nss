//::///////////////////////////////////////////////
//:: con_a1_garmgloat
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is Garm Gloating over the fallen player?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult = GetLocalInt(GetArea(OBJECT_SELF), "ncr_a1garmwin");
    SetLocalInt(GetArea(OBJECT_SELF), "ncr_a1garmwin", FALSE);

    return iResult;
}
