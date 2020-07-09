//January 2006
// B W-Husey
// PC has picked up father's will, but that's all.

int StartingConditional()
{

    // Inspect local variables
//    if(!(GetLocalInt(GetPCSpeaker(), "nGrave") == 1))
//        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "KnowLic") >0))
        return FALSE;

    return TRUE;
}


