// pirates of the moonsea:
// player has chosen to fight ilandra; she and her crew attack

#include "hf_in_plot"
#include "hf_in_npc"
#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("IlandraPirate", 3);
    AdjustPlayerAlignment(oPC, ALIGNMENT_EVIL, 5);

    // ilandra goes hostile and attacks the player
    object oIlandra = GetNearestObjectByTag("Ilandra", oPC);
    if (GetIsObjectValid(oIlandra))
    {
        GoHostile(oIlandra);
        AssignCommand(oIlandra, ActionAttack(oPC));
    }

    // blizzard goes hostile
    object oBlizzard = GetNearestObjectByTag("Blizzard", oPC);
    if (GetIsObjectValid(oBlizzard))
    {
        GoHostile(oBlizzard);
    }

    // ilandra's crew goes hostile
    int n = 1;
    object oCrew = GetNearestObjectByTag("IlandraCrew", oPC, n);
    while (GetIsObjectValid(oCrew))
    {
        GoHostile(oCrew);
        oCrew = GetNearestObjectByTag("IlandraCrew", oPC, ++n);
    }
}
