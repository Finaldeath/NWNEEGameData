// give the player enough xp to advance a level

void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentLevel = GetHitDice(oPC);
    int nGoalXP = (nCurrentLevel + 1) * nCurrentLevel * 500;
    if ( GetXP(oPC) < nGoalXP )
        SetXP(oPC,nGoalXP);
}
