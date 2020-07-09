//B W-Husey
// September 2005
// Londro Sidequest variable >2 and <9, quest has been taken and the Matron spoken to.
// Londro is still in the pub.

int StartingConditional()
{
    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") > 2 && GetLocalInt(GetPCSpeaker(), "LondroSide") < 9)
        return TRUE;

    return FALSE;
}
