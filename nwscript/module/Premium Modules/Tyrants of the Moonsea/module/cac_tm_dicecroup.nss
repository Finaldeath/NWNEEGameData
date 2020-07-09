//Croupier rolls three dice in game of 21 in Gate of Good Fortune casino

void main()
{
    int CUSTOM_TOKEN_ROLL = 5100;
    int CUSTOM_TOKEN_TOTAL = 5200;
    int CUSTOM_TOKEN_TARGET = 5300;
    int CUSTOM_TOKEN_CURRENT = 5400;

    int i = 1;
    int nRoll;
    int nRollTotal;
    int nRunningTotal = GetLocalInt(OBJECT_SELF, "nRunningTotal");
    int nTargetScore;

    location lDice;

    //Roll and create the three dice
    PlaySound("as_an_crittgnaw1");

    for(i = 1; i <= 3; i++)
    {
        nRoll = d6();
        nRollTotal += nRoll;

        lDice = GetLocation(GetNearestObjectByTag("Dice" + IntToString(i) + "Location"));
        CreateObject(OBJECT_TYPE_PLACEABLE, "tm_pl_dice6_0" + IntToString(nRoll),
                     lDice, FALSE, "Dice" + IntToString(i));
    }

    //Set Courier's current score
    SetCustomToken(CUSTOM_TOKEN_CURRENT, IntToString(nRunningTotal));

    //Get Player's final score
    nTargetScore = GetLocalInt(GetPCSpeaker(), "nRunningTotal");

    SetCustomToken(CUSTOM_TOKEN_ROLL, IntToString(nRollTotal));
    SetCustomToken(CUSTOM_TOKEN_TARGET, IntToString(nTargetScore));

    //Set Courier's new score
    nRunningTotal += nRollTotal;
    SetLocalInt(OBJECT_SELF, "nRunningTotal", nRunningTotal);
    SetCustomToken(CUSTOM_TOKEN_TOTAL, IntToString(nRunningTotal));
}
