// sidequest: shadovar search party
// thalia and her evil minions attack the player
// the quest XP is given out here instead of ondeath

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("Thalia", 2);

    GoHostile(OBJECT_SELF);

    int n = 1;
    object oMinion = GetNearestObjectByTag("ThaliaMinion", oPC, n);
    while (GetIsObjectValid(oMinion))
    {
        GoHostile(oMinion);
        oMinion = GetNearestObjectByTag("ThaliaMinion", oPC, ++n);
    }

    // if the spawns were previously made friendly, they are no longer
    n = 1;
    oMinion = GetNearestObjectByTag("ShadovarSpawn", oPC, n);
    while (GetIsObjectValid(oMinion))
    {
        GoHostile(oMinion);
        oMinion = GetNearestObjectByTag("ShadovarSpawn", oPC, ++n);
    }
}
