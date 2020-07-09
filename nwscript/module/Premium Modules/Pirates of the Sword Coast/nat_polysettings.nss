//::///////////////////////////////////////////////
//:: nat_polysettings
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script is Poly's Default physically
    attacked handler.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////
#include "inc_polyflee"

void main()
{
    object oPoly = OBJECT_SELF;
    object oAttacker = GetLastAttacker();

    ClearPersonalReputation(oAttacker, oPoly);
    AssignCommand(oPoly, SurrenderToEnemies());

    PolyFlee(oPoly);
}
