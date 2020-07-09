// does the player have the chicken? if so, they can open the thicket.

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oChicken = GetItemPossessedBy(oPC, "a2_chicken");
    return (GetIsObjectValid(oChicken));
}
