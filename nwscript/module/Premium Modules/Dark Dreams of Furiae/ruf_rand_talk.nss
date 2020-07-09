const int TALK_CHANCE_PCT = 5;

const string TALK_01 = "You look you can spare some coin...";
const string TALK_02 = "Your purse or your life. Ya know what, I'm going to just take both.";
const string TALK_03 = "Worldwine... you look like you have some...";
const string TALK_04 = "I need coin to dream... it hurts to much... it all hurts too much.";
const string TALK_05 = "I can smell it. You have worldwine on you...";

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == EVENT_HEARTBEAT)
    {
        // Check if we are in combat
        if (GetIsInCombat(OBJECT_SELF))
        {
            if (d100() <= TALK_CHANCE_PCT)
            {
                int nRandom = Random(5);

                if (nRandom == 0)
                {
                    ActionSpeakString(TALK_01);
                }
                else if (nRandom == 1)
                {
                    ActionSpeakString(TALK_02);
                }
                else if (nRandom == 2)
                {
                    ActionSpeakString(TALK_03);
                }
                else if (nRandom == 3)
                {
                    ActionSpeakString(TALK_04);
                }
                else if (nRandom == 4)
                {
                    ActionSpeakString(TALK_05);
                }
           }
       }
    }
}
