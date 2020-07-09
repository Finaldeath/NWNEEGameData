// chicken sees butcher and runs into the stronghold

#include "hf_in_plot"

void main()
{
    // the chicken flees into the stronghold
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF);
    object oWP = GetWaypointByTag("WP_AR1301_CHICKEN");
    PlotLevelSet("ks_druid_chick", 1);
    CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_chick", GetLocation(oWP));
    SpeakString("*Squwaak!*");
    SetLocalInt(OBJECT_SELF, "HF_EXIT_STARTED", 1);
    ActionMoveToObject(oDoor, TRUE, 0.1);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));
    DelayCommand(1.4, AssignCommand(oDoor, ActionCloseDoor(oDoor)));
    DestroyObject(OBJECT_SELF, 1.5);

    // the butcher talks to the player
    object oPC = GetPCSpeaker();
    object oButcher = GetNearestObjectByTag("ks_butcher", oPC);
    AssignCommand(oButcher, ClearAllActions());
    AssignCommand(oButcher, ActionStartConversation(oPC));
}
