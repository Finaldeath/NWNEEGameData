//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_shind
//:: DATE: December 30, 2018
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Artemis Entreri attacks (while keeping plot flag)
//::////////////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
    DetermineCombatRound();

    // Prioritize Astar (since he's the target)
    object oAstar = GetNearestObjectByTag("Astar");
    if (GetIsObjectValid(oAstar))
    {
        AssignCommand(OBJECT_SELF, ActionAttack(oAstar));
    }
}
