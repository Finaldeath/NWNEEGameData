//::///////////////////////////////////////////////
//:: Name x2_def_onblocked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnBlocked script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_blocked", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_defaulte", OBJECT_SELF);
    }
}
