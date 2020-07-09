//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: dtc_tm_zhentrn_e
//:: DATE: January 15, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Zhentil Keep Ruins - Door Transition
//::
//:: Entering the Ruins from Zhentil keep. Send player
//:: to random location
//::////////////////////////////////////////////////////

#include "inc_zhentrn"

void main()
{
    object oPC = GetClickingObject();
    object oRandomArea = ZHTRUIN_GetRandomTransitionArea(GetArea(OBJECT_SELF), oPC);
    object oRandomTransitionTarget = ZHTRUIN_GetRandomTransitionTarget(oRandomArea);

    ZHTRUIN_ExecuteEncounter(oRandomTransitionTarget, oPC);

    // Execute area transition
    ExploreAreaForPlayer(oRandomArea, oPC, FALSE);
    SetTransitionTarget(OBJECT_SELF, oRandomTransitionTarget);
    AssignCommand(oPC, JumpToObject(oRandomTransitionTarget));
}
