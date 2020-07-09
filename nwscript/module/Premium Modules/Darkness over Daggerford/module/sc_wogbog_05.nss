int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFood = GetItemPossessedBy(oPC, "db_toffeeapple");
    return(GetIsObjectValid(oFood));
}

