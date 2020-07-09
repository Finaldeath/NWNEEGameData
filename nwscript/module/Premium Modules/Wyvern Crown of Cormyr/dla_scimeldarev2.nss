//December 2005
// B W-Husey
// PC has Imelda's Revenge quest, and told Hawklin
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nRevenge") == 2))
        return FALSE;

    return TRUE;
}
