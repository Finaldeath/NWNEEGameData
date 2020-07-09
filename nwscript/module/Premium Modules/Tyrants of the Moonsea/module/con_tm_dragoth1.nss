// returns true when lyressa is in the party
// sidequest: dragoth the bone mage

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oLyressa = GetNearestObjectByTag("Lyressa", oPC);
    if (GetIsObjectValid(oLyressa))
    {
        return TRUE;
    }
    return FALSE;
}
