//::///////////////////////////////////////////////
//:: Name x2_def_percept
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Perception script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_percept", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_default2", OBJECT_SELF);
    }
}
