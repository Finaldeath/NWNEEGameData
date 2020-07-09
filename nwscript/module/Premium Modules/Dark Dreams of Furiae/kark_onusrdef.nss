#include "ddf_util"

const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void main()
{
    int nUser = GetUserDefinedEventNumber();

    //if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    if(nUser == 1001 || nUser == EVENT_HEARTBEAT || nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        if(GetLocalInt(GetModule(), "ddf_nm_1_finished") == TRUE) return;

        if(IsInConversation(OBJECT_SELF) == FALSE)
        {
            int bFound = FALSE;
            int nNth = 1;
            object oPlayerInSight = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                                       PLAYER_CHAR_IS_PC,
                                                       OBJECT_SELF,
                                                       nNth);
                                                       //,
                                                       //CREATURE_TYPE_PERCEPTION,
                                                       //PERCEPTION_SEEN);
            while (GetIsObjectValid(oPlayerInSight) && bFound == FALSE)
            {
                bFound = TRUE;

            }
            if(bFound)
            {
             ActionMoveToObject(oPlayerInSight, TRUE);
             ActionStartConversation (oPlayerInSight);
            }
        }
    }
}
