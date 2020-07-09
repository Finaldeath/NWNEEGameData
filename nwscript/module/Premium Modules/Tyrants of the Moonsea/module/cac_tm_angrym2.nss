// angrym jumps to the stables so that he can sell horses to the player

#include "hf_in_plot"
#include "hf_in_npc"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("Angrym", 2);

    FadeToBlack(oPC, FADE_SPEED_FAST);
    FreezeCreature(oPC);

    object oWP = GetWaypointByTag("WP_THAS_STABLE_ANGRYM");
    location lLoc = GetLocation(oWP);
    DelayCommand(1.0f, UnfreezeCreature(oPC));
    DelayCommand(1.5f, TeleportToWaypoint(oPC, "WP_THAS_STABLE_PLAYER"));
    DelayCommand(1.1f, AssignCommand(OBJECT_SELF, ActionJumpToLocation(lLoc)));
    DelayCommand(1.9f, AssignCommand(OBJECT_SELF, ActionStartConversation(oPC)));
    DelayCommand(2.0f, FadeFromBlack(oPC, FADE_SPEED_FAST));
}
