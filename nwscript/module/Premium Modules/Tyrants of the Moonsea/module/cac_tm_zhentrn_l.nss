//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_zhentrn_l
//:: DATE: January 15, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Zhentil Keep Ruins - Door Conversation
//:: PC leaves the ruins.
//::////////////////////////////////////////////////////

#include "inc_zhentrn"

void main()
{
    object oPC = GetPCSpeaker();
    object oTransitionTarget = GetObjectByTag(ZHTRUIN_TAG_EXIT_TRANSITION);

    AssignCommand(oPC, JumpToObject(oTransitionTarget));
}

