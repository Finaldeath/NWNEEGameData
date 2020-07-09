#include "ddf_util"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void StartConvo()
{
    if(GetLocalInt(GetModule(), HADLIEUTENANTDIALOG) == FALSE && IsInConversation(OBJECT_SELF) == FALSE)
    {
         object oPC = GetFirstPC();
         if(GetIsObjectValid(oPC))
         {
            BeginConversation("", oPC);
         }
    }
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

    }
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {

    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {

    }
    else if(nUser == 1007) // DEATH  - do not use for critical code, does not fire reliably all the time
    {

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {
        //debug("-- pre spawn!");
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        //debug("-- post spawn!");
        //StartConvo();
    }
}
