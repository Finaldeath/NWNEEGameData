#include "ddf_util"

void main()
{

    // 2019-08-26 JY
    // Created a single dialog from tedd_001 and tedd_002
    // (tedd_099)

    return;

    if (GetCurrentArea(GetPCSpeaker()) == AREA_ALADARAS_APARTMENT)
    {
        BeginConversation("tedd_002");
    }
    else
    {
        BeginConversation("tedd_001");
    }
}
