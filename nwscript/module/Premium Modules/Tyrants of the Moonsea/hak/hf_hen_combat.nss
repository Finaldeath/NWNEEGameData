#include "x0_inc_henai"
#include "hf_in_henchman"

void main()
{
    // do nothing if henchman is passive
    if (HenchmanIsPassive(OBJECT_SELF))
    {
        return;
    }

    // we don't want our druid to turn into a badger
    HenchmanRemoveFeat(OBJECT_SELF, FEAT_WILD_SHAPE);

    // decide on an action and add it to my queue
    if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        if (HenchmanCanSummonCompanion(OBJECT_SELF))
        {
            // druids and rangers like to have their friends nearby
            HenchmanSummonCompanion(OBJECT_SELF);
        }
        else
        {
            HenchmenCombatRound(OBJECT_INVALID);
        }
    }

    // signal end of combat round
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }
}
