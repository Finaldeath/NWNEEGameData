#include "ddf_util"

int StartingConditional()
{
    if(GetLocalInt(GetModule(), HADLIEUTENANTDIALOG) == TRUE) return TRUE;

    return FALSE;
}
