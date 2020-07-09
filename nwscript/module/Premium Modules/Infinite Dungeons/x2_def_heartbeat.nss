//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_heart", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_default1", OBJECT_SELF);
    }
}
