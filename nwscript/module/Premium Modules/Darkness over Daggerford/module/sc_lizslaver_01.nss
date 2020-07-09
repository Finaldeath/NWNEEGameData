// does the lizard slaver have his key (player might have already stolen it)

int StartingConditional()
{
    object oKey = GetItemPossessedBy(OBJECT_SELF, "ks_it_lizkey");
    return(GetIsObjectValid(oKey));
}
