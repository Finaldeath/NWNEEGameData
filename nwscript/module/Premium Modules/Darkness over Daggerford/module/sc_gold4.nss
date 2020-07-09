// does the player have 4 gold coins?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(GetGold(oPC) >= 1);
}


