// December 2005
// B W-Husey
// PC is a worshipper of Tempus

int StartingConditional()
{

    // Inspect local variables
    object oPC = GetPCSpeaker();
    if(GetDeity(oPC) == "Tempus")
        return TRUE;

    return FALSE;
}
