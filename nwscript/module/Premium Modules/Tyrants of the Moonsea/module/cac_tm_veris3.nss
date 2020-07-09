// sidequest: priates of the moonsea
// .. veris fights the player and a tavern-wide bar-fight ensues

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("Veris", 3);
    PlotLevelSet("CyriltheBarkeep", 3);

    // veris goes hostile and attacks the player
    object oVeris = GetNearestObjectByTag("Veris", oPC);
    if (GetIsObjectValid(oVeris))
    {
        GoHostile(oVeris);
        AssignCommand(oVeris, ActionAttack(oPC));
    }

    // veris' crew goes hostile -> bar fight!
    int n = 1;
    object oCrew = GetNearestObjectByTag("VerisCrew", oPC, n);
    while (GetIsObjectValid(oCrew))
    {
        GoHostile(oCrew);
        oCrew = GetNearestObjectByTag("VerisCrew", oPC, ++n);
    }
}
