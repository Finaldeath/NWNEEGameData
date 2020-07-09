// does the player have an empty bottle?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oBottle = GetItemPossessedBy(oPC, "NW_IT_THNMISC001");
    return(GetIsObjectValid(oBottle));
}
