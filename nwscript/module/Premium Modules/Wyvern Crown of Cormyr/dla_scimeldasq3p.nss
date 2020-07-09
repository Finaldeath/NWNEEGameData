//December 2005
// B W-Husey
// PC has got the 'Imelda's Revenge' sidequest. nRevenge>0, so it doesn't matter if it is finished.
// Used on other dialogues apart from Imelda's.

int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nRevenge") > 0))
        return FALSE;

    return TRUE;
}
