//::///////////////////////////////////////////////
//:: exe_a1_troghosti
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has made enemies of the troglodyte
    faction.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oTrogNeut = GetObjectByTag("a1_trogneut");
    object oCursor = GetFirstFactionMember(oTrogNeut, FALSE);

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        if (GetObjectType(oCursor) == OBJECT_TYPE_CREATURE)
        {
            DelayCommand(1.0f, ChangeToStandardFaction(oCursor, STANDARD_FACTION_HOSTILE));
            DelayCommand(1.5f, AssignCommand(oCursor, DetermineCombatRound()));
        }

        oCursor = GetNextFactionMember(oTrogNeut, FALSE);
    }
}
