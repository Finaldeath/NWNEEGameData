// does the player have a certain item?

int StartingConditional()
{
    string sTag = GetLocalString(OBJECT_SELF, "HF_ITEM_HAS");
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, sTag);
    return(GetIsObjectValid(oItem));
}
