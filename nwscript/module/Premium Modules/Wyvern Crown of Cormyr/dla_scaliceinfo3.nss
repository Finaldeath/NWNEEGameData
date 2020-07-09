//February 2006
// B W-Husey
// Alice has been asked for info and not yet given it
int StartingConditional()
{

   if(GetLocalInt(GetPCSpeaker(), "nAInfo") == 0)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nInfoPoltGot") == 1)
        return FALSE;
    return TRUE;
}
