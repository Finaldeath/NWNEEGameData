// April 2004
// B W-Husey
// Generic - the PC is injured.

int StartingConditional()
{
    if(GetCurrentHitPoints(GetPCSpeaker()) == GetMaxHitPoints(GetPCSpeaker()))
        return FALSE;
    return TRUE;
}
