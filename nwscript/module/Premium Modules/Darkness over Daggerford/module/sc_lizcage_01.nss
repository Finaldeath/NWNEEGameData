// does the player have the lizardfolk key?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(oPC, "ks_it_lizkey");
    return(GetIsObjectValid(oKey));
}
