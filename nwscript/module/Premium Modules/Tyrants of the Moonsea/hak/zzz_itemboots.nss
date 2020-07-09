// equip the party with boots of speed

void main()
{
    object oPC = GetPCSpeaker();
    object oBoots = CreateItemOnObject("nw_it_mboots005", oPC);
    SetIdentified(oBoots, TRUE);
    AssignCommand(oPC, ActionEquipItem(oBoots, INVENTORY_SLOT_BOOTS));
    int i = 1;
    for (i = 1; i < 9; i++)
    {
        object oHench = GetHenchman(oPC, i);
        if (GetIsObjectValid(oHench))
        {
            object oBoots = CreateItemOnObject("nw_it_mboots005", oHench);
            SetIdentified(oBoots, TRUE);
            AssignCommand(oHench, ActionEquipItem(oBoots, INVENTORY_SLOT_BOOTS));
        }
    }
}
