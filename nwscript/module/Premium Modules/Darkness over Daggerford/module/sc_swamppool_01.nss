// does the player have a jar of piranhas?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oJar = GetItemPossessedBy(oPC, "ks_it_piranhas");
    return(GetIsObjectValid(oJar));
}
