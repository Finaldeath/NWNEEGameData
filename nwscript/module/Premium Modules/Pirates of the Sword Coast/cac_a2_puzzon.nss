//::///////////////////////////////////////////////
//:: cac_a2_puzzon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This script will activate or reset the
     arrow puzzle in Vantabulars light house.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

#include "inc_a2_crystpuzz"

void main()
{
    ActionPauseConversation();
    ActivatePuzzle();
    DelayCommand(1.5f, ActionResumeConversation());
}
