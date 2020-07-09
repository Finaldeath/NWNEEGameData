// returns true when the player can rent a room at the beacon inn in thentia

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 10)
        return TRUE;
    return FALSE;
}
