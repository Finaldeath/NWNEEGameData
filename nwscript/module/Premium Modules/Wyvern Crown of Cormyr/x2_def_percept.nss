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

    // Deva  7/08/2006 - change added to reduce CPU utilization.  If this
    // does not help this script can simply be deleted and it will revert to
    // the default Bioware.  This script essentially says that we really do not
    // need this script to fire for every single NPC and PC this NPC perceives.
    // We only need it to react to enemies it perceives.  You can also
    // temporarily revert this by setting bOptimizePerception on the module
    // object to 0.  Tests show this reduces CPU utilization from
    // 0.15 msecs per call down to 0.01 msecs per call.  This is important
    // because, this script is called 1000s of times in a short period of time.
    // This means cpu utilization is reduced by approximately 93%!!
    object oPercep=GetLastPerceived();
    if (!GetIsEnemy(oPercep)&&GetLocalInt(GetModule(),"bOptimizePerception")) return;

    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}
