// does the player have xatuum's key?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(oPC, "ks_xatuum_key");
    return(GetIsObjectValid(oKey));
}
