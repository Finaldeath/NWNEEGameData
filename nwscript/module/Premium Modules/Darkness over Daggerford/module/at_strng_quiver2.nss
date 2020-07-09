// the player takes an arrow from the endless quiver

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, PlaySound("it_arrow_bolt"));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 3.0));
    CreateItemOnObject("nw_wamar001", oPC, 12);
}
