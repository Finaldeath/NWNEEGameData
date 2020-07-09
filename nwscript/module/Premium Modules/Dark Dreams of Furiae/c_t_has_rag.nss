#include "nw_i0_plot"
#include "ddf_util"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRag = 0;

    for (nRag = 0; nRag <= 6; nRag++)
    {
        if(HasItem(oPC, "rag_nspr_i" + IntToString(nRag)))
        {
            debug("-- found a rag, returning TRUE");
            return TRUE;
        }
    }

    debug("-- found no rag, return FALSE");
    return FALSE;
}
