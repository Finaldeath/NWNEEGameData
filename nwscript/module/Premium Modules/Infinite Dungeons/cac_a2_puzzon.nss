//::///////////////////////////////////////////////
//:: cac_a2_puzzon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This script will activate or reset the
     arrow puzzle in Vantabulars light house.

     Update July 21, 2005: Updated to use the
     include file for infinite dungeons.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

#include "inc_puz_crstpzzl"

void main()
{
    ActionPauseConversation();
    ActivatePuzzle();
    DelayCommand(1.5f, ActionResumeConversation());
}
