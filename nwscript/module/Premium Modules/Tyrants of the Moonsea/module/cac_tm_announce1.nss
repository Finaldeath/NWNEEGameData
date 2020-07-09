//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_announce1
//:: DATE: April 1, 2006.
//:: AUTH: Luke Scull
//:: NOTE: Dialog during arena cutscene.
//::////////////////////////////////////////////////////
//:: Player kills Blizzard
//::////////////////////////////////////////////////////

#include "cut_tm_arena_inc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("Blizzard-Arena-Outcome", 2);  // Blizzard killed, unfriendly towards PC

    // Kill Blizzard
    object oNPC = GetNearestObjectByTag(NPC_TAG_BLIZZARD, oPC);
    if (GetIsObjectValid(oNPC))
    {
        SetPlotFlag(oNPC, FALSE);
        SetImmortal(oNPC, FALSE);
        effect eDeath = EffectDeath();
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oNPC);
    }
}
