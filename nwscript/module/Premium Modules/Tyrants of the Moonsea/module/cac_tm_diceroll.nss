//Roll the dice in the game of 21 in Gate of Good Fortune casino

void main()
{
    object oPC = GetPCSpeaker();

    int CUSTOM_TOKEN_ROLL = 5100;
    int CUSTOM_TOKEN_TOTAL = 5200;

    int i = 1;
    int nRoll;
    int nRunningTotal = GetLocalInt(oPC, "nRunningTotal");
    int nRollTotal;

    location lDice;

    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 2.0, 1.0));

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

    //Store this dice roll for display in custom dialog token
    SetCustomToken(CUSTOM_TOKEN_ROLL, IntToString(nRollTotal));
    //Keep track of the player's running total
    nRunningTotal += nRollTotal;
    SetLocalInt(oPC, "nRunningTotal", nRunningTotal);
    SetCustomToken(CUSTOM_TOKEN_TOTAL, IntToString(nRunningTotal));
}
