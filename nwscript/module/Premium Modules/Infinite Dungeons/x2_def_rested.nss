//::///////////////////////////////////////////////
//:: Name x2_def_rested
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Rested script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_rest", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_defaulta", OBJECT_SELF);
    }
}
