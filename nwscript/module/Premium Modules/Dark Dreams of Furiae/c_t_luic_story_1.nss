// (If you've asked Luicil at least one question
// and have not yet finished Conversation 1)

#include "ddf_util"

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_luic_asked") != TRUE) return FALSE;
    if (GetLocalInt(GetModule(), "luicil_story_index") >= 1) return FALSE;

    return TRUE;

}
