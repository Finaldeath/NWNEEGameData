#include "x0_inc_henai"
#include "hf_in_henchman"

void main()
{
    // do nothing if henchman is passive
    if (HenchmanIsPassive(OBJECT_SELF))
    {
        PrintString("Passive");
        return;
    }

    // we don't want our druid to turn into a badger
    HenchmanRemoveFeat(OBJECT_SELF, FEAT_WILD_SHAPE);

    // decide on an action and add it to my queue
    if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        PrintString("Check can summon");
        if (GetHasFeat(FEAT_ANIMAL_COMPANION, OBJECT_SELF))
            PrintString("Has feat");

        if(GetLocalObject(OBJECT_SELF, "HF_HENCHMAN_COMPANION_OBJ") == OBJECT_INVALID)
            PrintString("Obj invalid");
        PrintString("Size = " + IntToString(HenchmanCountParty(OBJECT_SELF)));
        //if (HenchmanCanSummonCompanion(OBJECT_SELF))
        {
            // druids and rangers like to have their friends nearby
            PrintString("Summoning");
            HenchmanSummonCompanion(OBJECT_SELF);
        }
        //else
        {
        //    HenchmenCombatRound(OBJECT_INVALID);
        }
    }

    // signal end of combat round
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }
}
