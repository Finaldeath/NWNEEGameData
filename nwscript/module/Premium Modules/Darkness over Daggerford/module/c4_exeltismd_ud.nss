#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Panic(object oPC)
{
    string sText;
    int n = d6();
    if      (n == 1) sText = "Oh no! Intruders!";
    else if (n == 2) sText = "Help! Guards! Save us!";
    else if (n == 3) sText = "Invaders! Save us!";
    else if (n == 4) sText = "Help!";
    else if (n == 5) sText = "Run away!";
    else if (n == 6) sText = "Invaders in the castle! Help!";
    if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
    {
        PlaySound("as_pl_screamf2");
    } else {
        PlaySound("as_pl_screamm2");
    }
    ActionSpeakString(sText, TALKVOLUME_SHOUT);
    ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 2.0);
    ActionMoveAwayFromObject(oPC, TRUE, 25.0);
}

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        object oPC = GetFirstPC();
        if (GetObjectSeen(oPC))
        {
            Panic(oPC);
        }
    }
}

void Percieve()
{
    object oPC = GetLastPerceived();
    if (!GetIsInCombat(OBJECT_SELF))
    {
        if (GetIsPC(oPC))
        {
            ClearAllActions();
            Panic(oPC);
        }
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_PERCEIVE)
    {
        Percieve();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
    }
}
