// skully calls out to the player

#include "hf_in_plot"

void main()
{
    if (!IsInConversation(OBJECT_SELF))
    {
        string sText;
        int n = d4();
        if      (n == 1) sText = "Hey boss, you there?";
        else if (n == 2) sText = "Hello? Anybody home?";
        else if (n == 3) sText = "Where are you boss?";
        else if (n == 4) sText = "Yoo hoo! Hello?";
        SpeakString(sText);
    }
}
