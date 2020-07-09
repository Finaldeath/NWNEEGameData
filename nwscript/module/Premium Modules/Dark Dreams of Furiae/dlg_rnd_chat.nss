// THESE CONSTS ARE SET BY NPC VARIABLES
const string TOTAL_CHATS = "TOTAL_CHATS";
const string NPC0 = "NPC0";
const string NPC1 = "NPC1";
const string CHAT_PREFIX = "CHAT";
const string CHAT_CHANCE_PCT_OVERRIDE = "CHAT_CHANCE_OVERRIDE";

// THESE CONSTS ARE SET BY CODE
const string CHAT_TIMER = "iChatTimer";
const int CHAT_CHANCE_PCT_DEFAULT = 100;
const float CHAT_EXCHANGE_DELAY = 8.0;

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == EVENT_HEARTBEAT)
    {
        string sNPC0 = GetLocalString(OBJECT_SELF, NPC0);
        if (sNPC0 == "")
        {
            PrintString("DLG_RND_CHAT: Missing var " + NPC0);
            return;
        }

        string sNPC1 = GetLocalString(OBJECT_SELF, NPC1);
        if (sNPC1 == "")
        {
            PrintString("DLG_RND_CHAT: Missing var " + NPC1);
            return;
        }

        object oNPC0 = GetObjectByTag(sNPC0);
        object oNPC1 = GetObjectByTag(sNPC1);

        // If either object doesn't exist then don't play any gossip
        if (oNPC0 == OBJECT_INVALID || oNPC1 == OBJECT_INVALID)
        {
            return;
        }

        // If either object is in a conversation then don't play any gossip
        if (IsInConversation(oNPC0) || IsInConversation(oNPC1))
        {
            return;
        }

        int iChatTimer = GetLocalInt(OBJECT_SELF, CHAT_TIMER);

        // We need to wait another heartbeat before we can chat
        if (iChatTimer > 0)
        {
            SetLocalInt(OBJECT_SELF, CHAT_TIMER, --iChatTimer);
            return;
        }

        int iChatChance = CHAT_CHANCE_PCT_DEFAULT;

        // Check if there is an override
        int iChatChanceOverride = GetLocalInt(OBJECT_SELF, CHAT_CHANCE_PCT_OVERRIDE);
        if (iChatChanceOverride != 0)
        {
            iChatChance = iChatChanceOverride;
        }

        // We didn't hit our chat chance, return
        if (d100() > iChatChance)
        {
            return;
        }

        // We can chat!
        int iTotalChats = GetLocalInt(OBJECT_SELF, TOTAL_CHATS);

        if (iTotalChats == 0)
        {
            PrintString("DLG_RND_CHAT: Missing var " + TOTAL_CHATS);
        }

        int iChat = Random(iTotalChats);

        // Get all the chat strings
        string sChat0 = GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_0");
        string sChat1 = GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_1");
        string sChat2 = GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_2");
        string sChat3 = GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_3");
        string sChat4 = GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_4");

        if (sChat0 != "")
        {
            DelayCommand(CHAT_EXCHANGE_DELAY * 0, AssignCommand(oNPC0, SpeakString(sChat0)));
            SetLocalInt(OBJECT_SELF, CHAT_TIMER, 0);
        }
        if (sChat1 != "")
        {
            DelayCommand(CHAT_EXCHANGE_DELAY * 1, AssignCommand(oNPC1, SpeakString(sChat1)));
            SetLocalInt(OBJECT_SELF, CHAT_TIMER, 1);
        }
        if (sChat2 != "")
        {
            DelayCommand(CHAT_EXCHANGE_DELAY * 2, AssignCommand(oNPC0, SpeakString(sChat2)));
            SetLocalInt(OBJECT_SELF, CHAT_TIMER, 2);
        }
        if (sChat3 != "")
        {
            DelayCommand(CHAT_EXCHANGE_DELAY * 3, AssignCommand(oNPC1, SpeakString(sChat3)));
            SetLocalInt(OBJECT_SELF, CHAT_TIMER, 4);
        }
        if (sChat4 != "")
        {
            DelayCommand(CHAT_EXCHANGE_DELAY * 4, AssignCommand(oNPC0, SpeakString(sChat4)));
            SetLocalInt(OBJECT_SELF, CHAT_TIMER, 5);
        }
    }
}
