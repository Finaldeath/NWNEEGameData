//::///////////////////////////////////////////////
//::
//:: a3_bw_oe_watery
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for areas.
//::
//:: Randomly looks for nearby waypoints to apply
//:: lighting effects to - use in watery rooms.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 10/17/2005
//::
//:://////////////////////////////////////////////

#include "hf_in_spawn"

void main()
{
    object oEnterer = GetEnteringObject();

    SetFootstepType(FOOTSTEP_TYPE_SPIDER, oEnterer);

    if (GetIsPC(oEnterer))
    {
        SpawnEnter(oEnterer);

        int nNth = 0;
        object oReflector = GetObjectByTag("bw_reflector", nNth);
        while ((GetArea(oReflector) != OBJECT_SELF) && (GetIsObjectValid(oReflector)))
        {
            nNth += 1;
            oReflector = GetObjectByTag("bw_reflector", nNth);
        }

        if (!GetIsObjectValid(oReflector)) return;

        // only run effects if PC is near
        int nLights = (d6() + 2); // create 3 - 8 lights
        float fDelay = 0.0;

        while (nLights > 0)
        {
            if (fDelay > 0.0)
            {
                DelayCommand(fDelay, SignalEvent(oReflector, EventUserDefined(501))); // create light
            }
            else
            {
                SignalEvent(oReflector, EventUserDefined(501)); // create light
            }

            nLights -= 1;
            fDelay += (0.3 + (d4() * 0.1));  // 0.4 - 0.8 seconds
        }
    }
}
