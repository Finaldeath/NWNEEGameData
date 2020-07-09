//B W-Husey
// September 2005
// Londro Sidequest variable =3, failed to convince Matron.

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "LondroSide") == 3)
        return TRUE;

    return FALSE;
}
