// lookup the player's deity

void main()
{
    object oPC = GetPCSpeaker();
    string sGod = GetDeity(oPC);
    if (sGod == "")
    {
        sGod = "your god";
    }
    SetCustomToken(100, sGod);
}
