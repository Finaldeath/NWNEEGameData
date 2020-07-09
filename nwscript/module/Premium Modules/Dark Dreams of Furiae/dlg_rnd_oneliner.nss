const string TOTAL_LINES = "TOTAL_LINES";
const string LINE_PREFIX = "LINE";
const string TALK_CHANCE_PCT_OVERRIDE = "TALK_CHANCE_OVERRIDE";

const int TALK_CHANCE_PCT_DEFAULT = 15;

#include "ddf_util"

void main()
{
    int iType = GetObjectType(OBJECT_SELF);

    // Creature early outs
    if (iType == OBJECT_TYPE_CREATURE)
    {
        // Exit if it isn't a heartbeat event
        int nEvent = GetUserDefinedEventNumber();
        if (nEvent != EVENT_HEARTBEAT)
        {
            return;
        }

        // Exit if we are already in a conversation
        if (IsInConversation(OBJECT_SELF))
        {
            return;
        }

        // Exit if we are already speaking
        if (GetLocalInt(OBJECT_SELF, "speaking") == TRUE)
        {
            return;
        }
    }

    int talkChance = TALK_CHANCE_PCT_DEFAULT;

    // Check if there is an override
    int talkChanceOverride = GetLocalInt(OBJECT_SELF, TALK_CHANCE_PCT_OVERRIDE);
    if (talkChanceOverride != 0)
    {
        talkChance = talkChanceOverride;
    }

    if (d100() <= talkChance)
    {
        int maxLines = GetLocalInt(OBJECT_SELF, TOTAL_LINES);

        if (maxLines > 0)
        {
            int nRandom = Random(maxLines);
            string sLineVarName = LINE_PREFIX + IntToString(nRandom);
            string sLine = GetLocalString(OBJECT_SELF, sLineVarName);

            if (sLine != "")
            {
                SpeakString(sLine);
            }
            else
            {
                PrintString("DLG_RND_ONELINER: Missing line var [" + sLineVarName + "]");
            }
        }
        else
        {
            PrintString("DLG_RND_ONELINER: Missing total lines var TOTAL_LINES");
        }
    }
}
