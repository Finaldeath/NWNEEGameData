// returns true if the player has enough gold to buy angrym's horses

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nGold = GetGold(oPC);
    return (nGold >= 1500);
}
