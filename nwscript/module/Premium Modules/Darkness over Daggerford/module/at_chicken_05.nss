// the chicken emerges from the stronghold, looking for tasty corn
// ... but it's a chicken trap!

void main()
{
    // destroy the chicken inside the stronghold
    object oChicken = GetObjectByTag("ks_druid_chick");
    DestroyObject(oChicken);

    // stronghold door opens
    object oPC = GetPCSpeaker();
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, oPC);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));

    // create a new chicken
    object oButcher = GetNearestObjectByTag("ks_butcher", oPC);
    oChicken = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_chick", GetLocation(oDoor));
    SetLocalInt(oChicken, "HF_DISABLE_AM", 1);
    AssignCommand(oChicken, ActionMoveToObject(oButcher, TRUE, 0.1));
}
