//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ncr_tm_kazzvoon
// DATE: October 31, 2018
// AUTH: Rich Barker
// NOTE: Kazz teleports away after three rounds
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "NW_I0_GENERIC"

const int NUM_ROUNDS_TO_STAY = 2;

void ClearFollowersReputation(object oPC, object oTarget)
{
    int h = 1;
    int i;

    object oCreature;
    object oHench = GetHenchman(oPC, h);

    while(oHench != OBJECT_INVALID)
    {
        AssignCommand(oHench,ClearAllActions(TRUE));
        ClearPersonalReputation(oTarget,oHench);
        ClearPersonalReputation(oHench,oTarget);
        h++;
        oHench = GetHenchman(oPC, h);
    }

    for(i = ASSOCIATE_TYPE_ANIMALCOMPANION; i <= ASSOCIATE_TYPE_DOMINATED; i++)
    {
        oCreature = GetAssociate(i,oPC);
        if(oCreature != OBJECT_INVALID)
        {
            AssignCommand(oCreature,ClearAllActions(TRUE));
            ClearPersonalReputation(oTarget,oCreature);
            ClearPersonalReputation(oCreature,oTarget);
       }
    }
}

void main()
{
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }

    int nRound = GetLocalInt(OBJECT_SELF, "nRound");

    nRound++;
    SetLocalInt(OBJECT_SELF, "nRound", nRound);

    //Teleport away on round 3 of combat
    if(nRound > NUM_ROUNDS_TO_STAY)
    {
        object oPC = GetFirstPC();

        ClearAllActions(TRUE);
        SpeakString("Puny mortals! This is a waste of my time.", TALKVOLUME_SHOUT);
        SetPlotFlag(OBJECT_SELF, TRUE);
        SurrenderToEnemies();
        ClearPersonalReputation(oPC, OBJECT_SELF);
        ClearPersonalReputation(OBJECT_SELF, oPC);
        ClearFollowersReputation(oPC, OBJECT_SELF);

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(OBJECT_SELF));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_FNF_IMPLOSION) ,GetLocation(OBJECT_SELF));

        DestroyObject(OBJECT_SELF, 2.0);
    }
}
