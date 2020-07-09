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

    // Deva  7/08/2006 - This was added as an experiment to reduce lag.  This
    // will prevent extensive heartbeat actions from occurring while no PCs are
    // present.   If this fails to help or causes problems we can simply delete
    // this script and it will revert to the bioware one.
    // You can also temporarily disable this by setting bOptimizeHeartbeat on
    // the module object to 0. Tests show this reduces cpu utilization from
    // 0.26 msecs per call down to 0.06 msecs per call.  This is important
    // when you take into consideration this script is called 1000s of times
    // in a very short period of time.  This means utilization is reduced by
    // approximately 77%.
    if(!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC))&&GetLocalInt(GetModule(),"bOptimizeHeartbeat")) return;

    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
