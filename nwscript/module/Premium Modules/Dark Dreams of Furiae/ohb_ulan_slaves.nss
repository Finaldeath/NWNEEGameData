#include "ddf_util"

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
    if(GetLocalInt(GetModule(), "ddf_ulan_slaves_fleeing") == TRUE)
    {
        int iAction = GetCurrentAction();
        if(iAction != ACTION_MOVETOPOINT)
        {
            debug("-- retriggering ActiveFleeToExit... " + IntToString(GetFleeToExit()) + " " + GetName(OBJECT_SELF));
            ActivateFleeToExit();
        }
    }
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
