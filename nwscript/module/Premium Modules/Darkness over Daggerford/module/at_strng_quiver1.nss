// the player purchases the endless quiver of arrows
// .. it is automatically delivered to the stronghold

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(500, oPC, TRUE);
    AssignCommand(oPC, PlaySound("it_coins"));

    object oWP = GetWaypointByTag("WP_AR1301_FURN_QUIVER");
    object oQuiver = CreateObject(OBJECT_TYPE_PLACEABLE, GetResRef(OBJECT_SELF), GetLocation(oWP));
    SetLocalInt(oQuiver, "HF_ARG", 2);

    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
    DestroyObject(OBJECT_SELF, 0.5);
}
