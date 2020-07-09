// does the player have 1 gold coin?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(GetGold(oPC) >= 1);
}

