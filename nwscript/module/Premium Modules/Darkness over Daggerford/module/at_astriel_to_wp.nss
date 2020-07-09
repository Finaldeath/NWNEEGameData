//ActivateFleeToExit will cause an NPC to flee to a waypoint called EXIT_ + <NPC's tag>,
//and then destroy itself, optionally respawning at its spawn-in location.
//
//Author: Phil Mitchell (Baron of Gateford)

#include "NW_I0_GENERIC"
#include "hf_in_cutscene"

void main()
{
    //CutsceneNextShot();
    SetCutsceneMode(GetPCSpeaker(), FALSE);
    ActivateFleeToExit();
}
