//(if not law enforcement AND if have not chosen this option before)
#include "ddf_util"

int StartingConditional()
{
    string key = "ddf_gclerk_asked_question";

    // did you already ask this?
    if (GetLocalInt(GetModule(), key) == TRUE)
        return FALSE;

    // are you law inforcement?
    if (GetLocalInt(GetModule(), "ddf_background_flag") == BG_COP)
        return FALSE;


    SetLocalInt(GetModule(), key, TRUE);

    return TRUE;

}
