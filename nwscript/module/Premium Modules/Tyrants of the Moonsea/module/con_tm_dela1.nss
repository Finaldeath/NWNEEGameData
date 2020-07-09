// returns true when the player can rent a room at the traveler's cloak inn in mulmaster

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 10)
        return TRUE;
    return FALSE;
}
