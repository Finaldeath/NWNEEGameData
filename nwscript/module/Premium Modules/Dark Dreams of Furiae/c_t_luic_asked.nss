// 2019-03-13 JY --
// If you've asked at least one question AND Luicil is not currently your henchman, AND Luicil has not died while your henchman)

#include "ddf_util"

int StartingConditional()
{
    if(GetAssociateType(GetLastSpeaker()) == ASSOCIATE_TYPE_HENCHMAN) return FALSE;

    if(GetLocalInt(GetModule(), "ddf_luicil_died") == TRUE) return FALSE;

    if (GetLocalInt(GetModule(), "ddf_luic_asked") == TRUE)
    {
        debug("-- ddf_luic_asked == TRUE");

        return TRUE;
    }
    return FALSE;
}
