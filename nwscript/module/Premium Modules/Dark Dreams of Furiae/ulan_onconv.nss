#include "ddf_util"

void main()
{
    int iDay = GetCurrentDay();

    if (iDay < 4)
    {
        SpeakString("I'm conducting business here. If you aren't here to buy the flesh, kindly walk yours away.");
    }
    else if (iDay == 4 || iDay == 5)
    {
        int iHP = GetCurrentHitPoints();

        if (iHP == 1)
        {
            BeginConversation("ulan_002");
        }
        else
        {
            BeginConversation("ulan_001");
        }
    }
}
