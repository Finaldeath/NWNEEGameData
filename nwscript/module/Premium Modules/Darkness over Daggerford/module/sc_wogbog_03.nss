int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFood = GetItemPossessedBy(oPC, "db_bread2");
    return(GetIsObjectValid(oFood));
}
