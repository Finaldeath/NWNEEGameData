//::///////////////////////////////////////////////
//::
//:: a3_bw_oh_reflect
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Heartbeat script for placeables.
//::
//:: Randomly looks for nearby waypoints to apply
//:: lighting effects to - use in watery rooms.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/21/2005
//::
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1);

    if (GetIsObjectValid(oPC))
    {
        // only run effects if PC is near
        int nLights = (d6() + 3); // create 4 - 9 lights
        float fDelay = 0.0;

        while (nLights > 0)
        {
            if (fDelay > 0.0)
            {
                DelayCommand(fDelay, SignalEvent(OBJECT_SELF, EventUserDefined(501))); // create light
            }
            else
            {
                SignalEvent(OBJECT_SELF, EventUserDefined(501)); // create light
            }

            nLights -= 1;
            fDelay += (0.3 + (d4() * 0.1));  // 0.4 - 0.7 seconds
        }
    }
}
