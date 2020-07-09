//::///////////////////////////////////////////////
//:: nhb_polysettings
//:: Copyright (c) Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: Feb 2005
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    // JE: Failsafe - if for some reason poly got past the other cutscene
    // checks, then flee if the area is in a cutscene
    if(cs_GetCutsceneRunning(GetArea(OBJECT_SELF)))
    {
        if(GetTag(OBJECT_SELF)==a1c_tag_Poly) PolyFlee(OBJECT_SELF, TRUE);
        return;
    }
    //ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
