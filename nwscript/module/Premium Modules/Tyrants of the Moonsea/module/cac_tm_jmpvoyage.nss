// Return to Voyager after final part of Naval Battle with Avagard

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    int nXP;
    object oPC = GetPCSpeaker();

    TeleportToWaypoint(oPC, "WP_MOBT_CS_PC_SHIP", TRUE);
    PlotLevelSet("PirateBlockade", 3);
    MusicBackgroundStop(GetArea(oPC));
    //Update journal and award quest completion xp
    AddJournalQuestEntry("ThePirateKingsBlockade", 50, oPC);
    nXP = GetJournalQuestExperience("ThePirateKingsBlockade");
    GiveXPToCreature(oPC, nXP);
}
