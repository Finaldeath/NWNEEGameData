// nagnorm and the player teleport to urith's cage

#include "hf_in_npc"
#include "hf_in_plot"
#include "hf_in_cutscene"

void Teleport(object oSelf, object oPC)
{
    object oWP = GetWaypointByTag("WP_AR1003_CAGE_NPC");
    AssignCommand(oSelf, ClearAllActions());
    AssignCommand(oSelf, ActionJumpToObject(oWP, FALSE));
}

void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    PlotLevelSet(GetTag(OBJECT_SELF), 4);
    FadeToBlack(oPC);
    DelayCommand(1.5, TeleportToWaypoint(oPC, "WP_AR1003_CAGE_PC", FALSE));
    DelayCommand(1.5, Teleport(oSelf, oPC));
    DelayCommand(2.0, CutscenePlay(oPC, "mv_ar1003_1"));
}
