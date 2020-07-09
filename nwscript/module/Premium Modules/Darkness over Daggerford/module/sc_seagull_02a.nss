// does the player not have the druid's bloodstone?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oStone = GetItemPossessedBy(oPC, "ks_it_bloodstn");
    return(!GetIsObjectValid(oStone));
}
