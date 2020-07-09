// THESE CONSTS ARE SET BY CODE
const string CHAT_TIMER = "iChatTimer_RSS";
const int CHAT_CHANCE_PCT_DEFAULT = 100;
const float CHAT_EXCHANGE_DELAY = 4.0;

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent != EVENT_HEARTBEAT) return;

    object oNPC0 = GetObjectByTag("NPC_DDF_RASH");
    object oNPC1 = GetObjectByTag("NPC_DDF_SKIDS");
    object oNPC2 = GetObjectByTag("NPC_DDF_SCRAPPER");


        // If either object doesn't exist then don't play any gossip
        if (oNPC0 == OBJECT_INVALID || oNPC1 == OBJECT_INVALID || oNPC2 == OBJECT_INVALID)
        {
            return;
        }

        // If either object is in a conversation then don't play any gossip
        if (IsInConversation(oNPC0) || IsInConversation(oNPC1) || IsInConversation(oNPC2))
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

        int iChatChance = 50;



        // We didn't hit our chat chance, return
        if (d100() > iChatChance)
        {
            return;
        }



        // Get all the chat strings
        string sChat0 = "Seen anything worth reporting?";  // GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_0");
        string sChat1 = "The piss-poor quality of their ships?"; //GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_1");
        string sChat2 = "He means about *her*, dummy."; //GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_2");
        string sChat3 = "";//GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_3");
        string sChat4 = "";//GetLocalString(OBJECT_SELF, CHAT_PREFIX + IntToString(iChat) + "_4");

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
            DelayCommand(CHAT_EXCHANGE_DELAY * 2, AssignCommand(oNPC2, SpeakString(sChat2)));
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
