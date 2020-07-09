// returns true when the player can rent a room at the pride of zhentil keep

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 2)
        return TRUE;
    return FALSE;
}
