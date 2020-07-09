// create holy water at stronghold altar

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, PlaySound("it_potion"));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
    CreateItemOnObject("x1_wmgrenade005", oPC, 1);
}
