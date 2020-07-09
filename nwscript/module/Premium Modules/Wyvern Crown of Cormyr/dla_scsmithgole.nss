/*
    DLA_SCSMITHGOLE.nss
    gaoneng erick
    may 12, 2005

    checks if player has raw materials ready
*/
int StartingConditional()
{
    object self = OBJECT_SELF,
           pc = GetPCSpeaker();
    int   shardnum = GetLocalInt(self, "nShards");   //Number of shards/blades to use in reforging
    string special = GetLocalString(self, "sSpecial");  //special ingredient selected (Tag)
    if (!GetIsObjectValid(GetItemPossessedBy(pc, special))) return TRUE; // do not have special ingredient
    int i;
    object item = GetFirstItemInInventory(pc);
    while (GetIsObjectValid(item))
    {
        if (GetStringLeft(GetTag(item), 5) == "Shard") i++;
        item = GetNextItemInInventory(pc);
    }
    if (i < shardnum) return TRUE; // do not have enough shards
    return FALSE;
}
