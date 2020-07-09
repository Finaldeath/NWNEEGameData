// the player has opened the coffin in AR2009
// .. spawn a vampire

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    // open the coffin
    PlayAnimation(ANIMATION_PLACEABLE_OPEN);
    PlaySound("as_dr_x2ttu3op");
    PlotLevelSet(GetTag(OBJECT_SELF), 1);

    // spawn the vampire
    object oWP = GetWaypointByTag("WP_AR2009_VAMP0");
    object oVamp = CreateObject(OBJECT_TYPE_CREATURE, "ac_nosfiraat", GetLocation(oWP));
    DelayCommand(0.5, AssignCommand(oVamp, ActionStartConversation(oPC)));
}
