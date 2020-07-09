//::///////////////////////////////////////////////
//:: cac_polyflee
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will cause poly to fly away
    through conversation.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////
#include "inc_polyflee"

void main()
{
    object oPC = GetPCSpeaker();
    object oPoly = OBJECT_SELF;

    PolyFlee(oPoly);
}
