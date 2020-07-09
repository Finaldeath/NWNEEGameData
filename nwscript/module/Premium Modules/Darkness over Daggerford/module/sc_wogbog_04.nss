int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oFood = GetItemPossessedBy(oPC, "db_bread1");
    return(GetIsObjectValid(oFood));
}

