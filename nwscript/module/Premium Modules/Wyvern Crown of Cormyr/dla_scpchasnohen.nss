//B W-Husey (B G P Hughes)
// September 2005
// PC has noe henchman. Make sure that a horse henchman falls in this category (unless you are
// having talking horses)
#include "cu_functions"
int StartingConditional()
{
    if (ReturnHenchman(GetPCSpeaker(),1) != OBJECT_INVALID)
    return FALSE;
    else
    return TRUE;
}
