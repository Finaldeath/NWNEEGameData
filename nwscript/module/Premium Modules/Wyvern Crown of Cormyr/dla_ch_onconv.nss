#include "dla_i0_horse"

// Gale 07/06/05 - Changed implementation a little bit.
int AbleToTalk(object oSelf);

void main()
{
    object oShouter = GetLastSpeaker();
    object oMaster = GetMaster();
    int nMatch = GetListenPatternNumber();

    // listening pattern matched
    if(GetIsObjectValid(oMaster) && GetIsObjectValid(oShouter) && oMaster == oShouter && AbleToTalk(OBJECT_SELF))
    {
        // we have a master, only listen to them
            SetCommandable(TRUE);

            if (nMatch == ASSOCIATE_COMMAND_LEAVEPARTY)
            {
               if(GetAssociateType(OBJECT_SELF) == ASSOCIATE_TYPE_HENCHMAN)
               {
                   DLA_RemoveHenchman(oMaster, OBJECT_SELF, TRUE, TRUE);
                   return;
               }
            }
    }

    ExecuteScript("nw_ch_ac4",OBJECT_SELF);
}

// Gale 07/06/05 - Changed implementation a little bit.
int AbleToTalk(object oSelf)
{
    return GetCommandable(oSelf) ||
        !((GetHasEffect(EFFECT_TYPE_CONFUSED, oSelf)
        || GetHasEffect(EFFECT_TYPE_DOMINATED, oSelf)
        || GetHasEffect(EFFECT_TYPE_PETRIFY, oSelf)
        || GetHasEffect(EFFECT_TYPE_PARALYZE, oSelf)
        || GetHasEffect(EFFECT_TYPE_STUNNED, oSelf)
        || GetHasEffect(EFFECT_TYPE_FRIGHTENED, oSelf)));
}
