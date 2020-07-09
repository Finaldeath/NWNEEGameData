//December 2005
// B W-Husey
// PC knows that Huntcrown is interested in horns and/or hunting. Kathryn was the source (and not here)
#include "cu_functions"

int StartingConditional()
{

    // Inspect local variables
    if((GetLocalInt(GetPCSpeaker(), "nHOrder") == 2) &&  (GetInParty("Kathryn",GetPCSpeaker()) == FALSE))
    return TRUE;
    return FALSE;
}
