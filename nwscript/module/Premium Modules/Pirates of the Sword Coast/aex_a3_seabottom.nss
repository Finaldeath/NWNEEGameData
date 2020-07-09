//::///////////////////////////////////////////////
//:: aex_a3_seabottom
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Remove any bubble effects the PC may have.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////
#include "inc_bubbles"

void main()
{
    //tiny bubbles...bye bye
    object oPC = GetExitingObject();
    RemoveBubbles(oPC);
}
