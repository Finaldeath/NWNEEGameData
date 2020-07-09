// does the player have Nagnorm's key?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(oPC, "ks_it_nagkey");
    return(GetIsObjectValid(oKey));
}
