// equip the player with a powerful weapon

void main()
{
    object oPC = GetPCSpeaker();
    object oClub = CreateItemOnObject("cluboftesting", oPC);
    SetIdentified(oClub, TRUE);
    AssignCommand(oPC, ActionEquipItem(oClub, INVENTORY_SLOT_RIGHTHAND));
}
