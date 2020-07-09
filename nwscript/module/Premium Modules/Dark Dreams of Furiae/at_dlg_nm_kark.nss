#include "ddf_util"

void main()
{
    // spawn kark [resref 'karkualii002']
    // have kark move to the player(s)
    // start dialog nmka_000
    // once that is done return to the non-nightmare your apartment.

    // I think here all i have to do is spawn kark, the NPC should
    // take care of the finding/speaking of the dialog itself
    // and that dialog should then kick off the teleport to non-dream world.

    object oModule = GetModule();

    if(GetLocalInt(oModule, "ddf_nightmare_kark_spawned") == TRUE) return;
    SetLocalInt(oModule, "ddf_nightmare_kark_spawned", TRUE);

    object oPC = GetPCSpeaker();
    location lLocation = GetLocation(GetObjectByTag("YourApartmentStartNM"));
    object oKark = CreateObject(OBJECT_TYPE_CREATURE, "karkualii002", lLocation);
    debug("Spawning kark " + GetName(oKark) + " location " + LocationToString(lLocation));
    DelayCommand(1.0, AssignCommand(oKark, ActionMoveToObject(oPC, TRUE)));
    DelayCommand(1.5, AssignCommand(oKark, ActionStartConversation(oPC)));
}
