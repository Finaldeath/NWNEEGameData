//::///////////////////////////////////////////////
//:: nhb_fightclub
//:: Based on x2_def_heartbeat
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Heartbeat script for the fighters in
    Redtip's warehouse.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 14/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip, GetArea(OBJECT_SELF));
    // If the fightclub fight is active, and this guy is supposed to lose
    // then check to see if we should recenter the camera.
    // There is no particular reason for running this on the loser, except
    // that there's no point in running this on more than one of the fighters.
    if( (GetLocalInt(oRedtip, l_n_FIGHTCLUB_FIGHTACTIVE)) &&
        (GetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_PARTICIPANT) == l_nv_FIGHTCLUB_PARTICIPANT_LOSER) )
    {
        // figure out where the two fighters are
        object oFighter1 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER1);
        object oFighter2 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER2);
        vector vFighter1 = GetPosition(oFighter1);
        vector vFighter2 = GetPosition(oFighter2);
        // figure out where the point right in between the fighters is
        vector vCamera;
        object oArea = GetArea(OBJECT_SELF);
        vCamera.x = (vFighter1.x + vFighter2.x) / 2;
        vCamera.y = (vFighter1.y + vFighter2.y) / 2;
        vCamera.z = vFighter1.z;
        location lCamera = Location(oArea, vCamera, 0.0);
        // check to see how far the camera is from that point, and if
        // too far, move the camera there
        object oPC = cs_GetPCObject(0, oArea); // this fight is run in cutscene mode, so I can do this
        if(GetDistanceBetweenLocations(lCamera, GetLocation(oPC)) > 2.0)
        {
            cs_CameraSetMovementRate(0.0, 0.5, oArea);
            cs_CameraActionMoveToLocation(0.0, lCamera, FALSE, oArea);
        }
    }


    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
