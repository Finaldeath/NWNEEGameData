// ambient script for green hag in AR1801
// .. she just wanders between her kettle and her table

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

string GetRandomSaying1()
{
    string s;
    int n = d12();
    if      (n == 1)  s = "... Eye of newt ...";
    else if (n == 2)  s = "... Ogre's tooth ...";
    else if (n == 3)  s = "... Boil ... Boil ...";
    else if (n == 4)  s = "... Hmm. Too salty ...";
    else if (n == 5)  s = "... Claw of bat ...";
    else if (n == 6)  s = "... Tongue of squid ...";
    else if (n == 7)  s = "... Hmm. Tastes like chicken ...";
    else if (n == 8)  s = "... Toenail of slaad ...";
    else if (n == 9)  s = "... Look what's cooking in my pot! ...";
    else if (n == 10) s = "... How I love my potions hot! ...";
    else if (n == 11) s = "... Yum! Smells like swamp gas! ...";
    else if (n == 12) s = "... Hmm. Needs more beetle dung ...";
    return(s);
}

string GetRandomSaying2()
{
    string s;
    int n = d6();
    if      (n == 1) s = "Where did I put that Stinkweed?";
    else if (n == 2) s = "I thought I had some more frog's liver!";
    else if (n == 3) s = "Toad tongues. Ah. Under the snake stomachs.";
    else if (n == 4) s = "Bat dung. Extra spicy.";
    else if (n == 5) s = "*sniff* Argh! My beetle dung has gone bad!";
    else if (n == 6) s = "Where did I put those beetle brains?";
    return(s);
}

void Heartbeat()
{
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
    {
        object oPot = GetNearestObjectByTag("pl_hag_pot");
        object oTable = GetNearestObjectByTag("pl_hag_table");
        int nState = GetLocalInt(OBJECT_SELF, "nState");
        string sQuote = GetLocalString(OBJECT_SELF, "sQuote");

        ClearAllActions();
        if (nState == 0)
        {
            // walk to pot and mutter
            ActionMoveToObject(oPot);
            ActionWait(1.0);
            ActionSpeakString(sQuote + GetRandomSaying1() + sQuote);
            SetLocalInt(OBJECT_SELF, "nState", 1);
        }
        else if (nState == 1)
        {
            // walk to table
            ActionMoveToObject(oTable);
            ActionWait(1.0);
            ActionSpeakString(sQuote + GetRandomSaying2() + sQuote);
            SetLocalInt(OBJECT_SELF, "nState", 0);
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
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
