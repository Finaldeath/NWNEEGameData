// does the player have quicksilver?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oQuicksilver = GetItemPossessedBy(oPC, "ks_it_quicksilver");
    return(GetIsObjectValid(oQuicksilver));
}
