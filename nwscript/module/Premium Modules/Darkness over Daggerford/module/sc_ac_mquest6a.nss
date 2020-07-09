#include "hf_in_plot"

int StartingConditional()
{

    // If failed miller quest but shown Conway's note, store open
    if((GetLocalInt(GetPCSpeaker(), "ac_miller_quest") == 6) &&
        GetLocalInt(GetModule(), "iShownMaerovynaNote") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}
