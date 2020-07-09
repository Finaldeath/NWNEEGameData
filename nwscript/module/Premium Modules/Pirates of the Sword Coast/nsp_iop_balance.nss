//::///////////////////////////////////////////////
//:: nsp_iop_balance
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Modify the NPCs level to be chanllenging to the
    party currently playing the module.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_balance"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void main()
{
    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");

    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
        SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    LevelUpNPC(OBJECT_SELF);
    ExecuteScript("exe_gen_loot", OBJECT_SELF);
    ExecuteScript("nw_c2_default9", OBJECT_SELF);

    //Post Spawn event requeste
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
        SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }
}
