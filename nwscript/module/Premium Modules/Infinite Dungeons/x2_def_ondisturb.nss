//::///////////////////////////////////////////////
//:: Name x2_def_ondisturb
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDisturbed script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_disturb", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_default8", OBJECT_SELF);
    }
}
