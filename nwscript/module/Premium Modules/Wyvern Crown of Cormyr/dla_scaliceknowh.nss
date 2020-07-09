// January 2006
// B W-Husey
// Alice already told PC about horn

int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"nHOrder")==1)
        return TRUE;

    return FALSE;
}


