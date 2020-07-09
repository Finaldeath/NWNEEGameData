// the player has opened the cage door inside the slaver's hut

#include "nw_i0_generic"

void GoHostile(string sTag, object oPC)
{
    object oLizard = GetNearestObjectByTag(sTag, oPC);
    AdjustReputation(oPC, oLizard, -100);
    AssignCommand(oLizard, SetFacingPoint(GetPosition(oPC)));
    AssignCommand(oLizard, SpeakString("*hiss*"));
    AssignCommand(oLizard, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));
    AssignCommand(oLizard, DetermineCombatRound(oPC));
}

void main()
{
    object oPC = GetPCSpeaker();

    // any nearby lizards attack the player
    GoHostile("lizwatcher1", oPC);
    GoHostile("lizwatcher2", oPC);
    GoHostile("lizslaver", oPC);

    // the door is destroyed
    DestroyObject(OBJECT_SELF);
}
