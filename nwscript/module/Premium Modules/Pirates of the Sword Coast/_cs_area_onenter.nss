//::///////////////////////////////////////////////
//:: Cutscene system - Default area on-enter script
//:: _cs_area_onenter.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a default area on-enter script. If you
    do not need any other special scripting in the
    on-enter event of an area running a cutscene,
    you can simply attach this script to the event.

    If you need other scripting in the event, make
    your own script, and just ensure that you
    include the "#include" line, and the
    "cs_AreaOnEnter" function at the top of
    void main().
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Dec. 9, 2003
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    // If a cutscene is running, adds the PC to the cutscene.
    // The function ensures that only PC's get added, and not DM's,
    // or any other object for that matter.
    cs_AreaOnEnter(GetEnteringObject());
}
