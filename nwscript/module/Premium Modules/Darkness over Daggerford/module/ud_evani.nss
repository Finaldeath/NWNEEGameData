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
void EvaniCurse();
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {
    if (IsInConversation(OBJECT_SELF) == FALSE && GetIsInCombat() == FALSE
        && !GetLocalInt(GetModule(),"evani_fixed")==1)
        {
        ActionDoCommand(SetFacingPoint(GetPosition(GetNearestObjectByTag("wp_fantabulizer"))));
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 2.0, 2.0);
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,2.0,2.0);
        ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 2.0,2.0);
        if(d3()==1)
            {
            EvaniCurse();
            }
        }
    if (IsInConversation(OBJECT_SELF) == FALSE && GetIsInCombat() == FALSE
        && GetLocalInt(GetModule(),"holdfast_party_active")==1)
        {
        ActionDoCommand(SetFacingPoint(GetPosition(GetNearestObjectByTag("wp_fantabulizer"))));
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 6.0);
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
void EvaniCurse()//speakstring cursing the machine
{
string q = GetLocalString(GetModule(), "QUOTE");

int iCurse = d4();
switch(iCurse)
    {
    case 1: SpeakString(q+"Damn this thing! It was working last night!"+q); break;
    case 2: SpeakString(q+"It looks like... No, that can't be it."+q); break;
    case 3: SpeakString(q+"The projecterizer is connected to the moverizer? Check."+q); break;
    case 4: SpeakString(q+"This is downright suspicious. What can possibly have gone wrong?"+q); break;
    }
}
