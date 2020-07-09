// does the player have a bag of dirt?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oDirt = GetItemPossessedBy(oPC, "ks_it_dirtbag");
    return(GetIsObjectValid(oDirt));
}
