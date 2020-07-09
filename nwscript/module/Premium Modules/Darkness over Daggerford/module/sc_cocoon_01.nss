// does the player have a flask of acid?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "X1_WMGRENADE001");
    return (GetIsObjectValid(oItem));
}
