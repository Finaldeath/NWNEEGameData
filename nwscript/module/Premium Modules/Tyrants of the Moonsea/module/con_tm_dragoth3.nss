// lyressa decides if she should undergo the ritual based on the player
// sidequest: dragoth the bone mage
// TBD: perhaps this should be based on the number of times that the player made evil choices in the game

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        return TRUE;
    }
    return FALSE;
}
