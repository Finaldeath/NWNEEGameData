// does the player have the item stored in sItem variable?

int StartingConditional()
{
    int iResult;
    string sItem = GetLocalString(OBJECT_SELF, "sItem");
    return(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), sItem)));
}
