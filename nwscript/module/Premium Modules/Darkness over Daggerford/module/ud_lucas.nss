//::///////////////////////////////////////////////
//:: Name x2_def_userdef
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On User Defined Event script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
void LucasLeathered();
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {
        if(IsInConversation(OBJECT_SELF)==FALSE&&GetIsInCombat()==FALSE &&
           GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") == 0)
        {
        ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 2.0, 2.0);
        ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK,2.0,2.0);
        ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 2.0,2.0);
        if(d4()==1)
            {
            LucasLeathered();
            }
        }
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

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {

    }


}
void LucasLeathered()//speakstring being drunk and guilty
{
int iCurse = d4();
switch(iCurse)
    {
    case 1: SpeakString("Shtoopid fing ish what it ish!"); break;
    case 2: SpeakString("Head shtil hurts like hell..."); break;
    case 3: SpeakString("What am I doing out here alls 'lone?"); break;
    case 4: SpeakString("I'll take it back inda morning. No! Ish zhnot shafe..."); break;
    }
}

