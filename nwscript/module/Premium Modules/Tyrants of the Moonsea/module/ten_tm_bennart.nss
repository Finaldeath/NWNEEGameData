//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_bennart
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: If player is carrying Bennart, fade out screen
//       then spawn him in, destroying the inventory
//       version. Set int so that Bennart recognizes
//       he is free and trigger doesn't fire again.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC)) return;

    if (GetItemPossessedBy(oPC, "BennartWaters")== OBJECT_INVALID)
       return;


    if (GetLocalInt(OBJECT_SELF, "fired") == 1)
       return;

    FadeToBlack(oPC, FADE_SPEED_FASTEST);

    SetLocalInt(oPC, "bennartrescued", 1);

    object oItem = GetItemPossessedBy(oPC, "BennartWaters");

    DestroyObject(oItem);

    object oTarget;
    location lTarget;
    oTarget = GetWaypointByTag("WP_Bennart_Spawn");

    lTarget = GetLocation(oTarget);

    object oBennart = CreateObject(OBJECT_TYPE_CREATURE, "bennart", lTarget);
    DelayCommand(1.0, AssignCommand(oBennart, ActionStartConversation(oPC)));
    DelayCommand(1.4, AssignCommand(oPC, SetCameraFacing(135.0, 20.0, 45.0)));
    DelayCommand(1.5, FadeFromBlack(oPC));

    SetLocalInt(OBJECT_SELF, "fired", 1);
}
