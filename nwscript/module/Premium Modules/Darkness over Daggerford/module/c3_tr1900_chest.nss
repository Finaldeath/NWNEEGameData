// if the lizard crafter's chest is damaged or opened he gets very angry

#include "NW_I0_GENERIC"

void main()
{
    object oPC = GetFirstPC();
    object oLizard = GetNearestObjectByTag("lizcrafter", OBJECT_SELF);
    if (GetIsObjectValid(oLizard))
    {
        if (!GetIsEnemy(oPC, oLizard))
        {
            AdjustReputation(oPC, oLizard, -100);
            AssignCommand(oLizard, PlaySound("c_lizardm_bat1"));
            AssignCommand(oLizard, ClearAllActions());
            AssignCommand(oLizard, ActionSpeakString("*hiss*"));
            AssignCommand(oLizard, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
            AssignCommand(oLizard, DetermineCombatRound(oPC));
        }
    }
}
