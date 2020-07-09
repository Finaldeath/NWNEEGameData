//December 2005
// B W-Husey
// PC has Imelda's Revenge quest, not finished
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nRevenge") == 0)
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(), "nRevenge") > 2)
        return FALSE;

    return TRUE;
}
