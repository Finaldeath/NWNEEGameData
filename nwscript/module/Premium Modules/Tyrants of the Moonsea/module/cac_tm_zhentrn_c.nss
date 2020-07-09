//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_zhentrn_c
//:: DATE: January 15, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Zhentil Keep Ruins - Door Conversation
//:: PC continues exploring.
//::
//:: The PC will be transitioned to a random
//:: transition on one of the other Zhentil Keep Ruin
//:: areas.
//:: The script will also set up a random encounter.
//::////////////////////////////////////////////////////

#include "inc_zhentrn"

void main()
{
    object oPC = GetPCSpeaker();
    object oRandomArea = ZHTRUIN_GetRandomTransitionArea(GetArea(OBJECT_SELF), oPC);
    object oRandomTransitionTarget = ZHTRUIN_GetRandomTransitionTarget(oRandomArea);

    ZHTRUIN_ExecuteEncounter(oRandomTransitionTarget, oPC);

    // Execute area transition
    ExploreAreaForPlayer(oRandomArea, oPC, FALSE);
    SetTransitionTarget(OBJECT_SELF, oRandomTransitionTarget);
    AssignCommand(oPC, JumpToObject(oRandomTransitionTarget));
}
