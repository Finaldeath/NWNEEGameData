//December 2005
// B W-Husey
// PC has Imelda's Revenge quest, but not told Hawklin
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nRevenge") == 1))
        return FALSE;

    return TRUE;
}
