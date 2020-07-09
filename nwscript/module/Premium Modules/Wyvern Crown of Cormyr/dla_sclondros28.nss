//B W-Husey
// September 2005
// Londro Sidequest variable =2 and <9, quest has been taken and not completed.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") < 2)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") > 8)
        return FALSE;

    return TRUE;
}
