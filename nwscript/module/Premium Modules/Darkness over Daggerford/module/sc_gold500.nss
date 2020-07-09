//luspr -- has the player got enough money?

int StartingConditional()
{

    object oPC = GetPCSpeaker();
    if(GetGold(oPC) >= 500)
    return TRUE;
    return FALSE;
}
