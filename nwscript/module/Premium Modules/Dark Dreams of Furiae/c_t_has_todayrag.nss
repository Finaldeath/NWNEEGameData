#include "nw_i0_plot"
#include "ddf_util"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRag = GetCurrentDay();

    if(HasItem(oPC, "rag_nspr_i" + IntToString(nRag)))
    {
        return TRUE;
    }

    return FALSE;
}
