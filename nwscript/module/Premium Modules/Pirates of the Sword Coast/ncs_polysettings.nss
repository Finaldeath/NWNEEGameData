//::///////////////////////////////////////////////
//:: ncs_polysettings
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script is Poly's Default Spell cast at
    handler.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////
#include "inc_polyflee"

void main()
{
    object oPoly = OBJECT_SELF;
    object oCaster = GetLastSpellCaster();
    int iHarmful = GetLastSpellHarmful();

    if (iHarmful == TRUE)
    {
        ClearPersonalReputation(oCaster, oPoly);
        AssignCommand(oPoly, SurrenderToEnemies());

        PolyFlee(oPoly);
    }
}

