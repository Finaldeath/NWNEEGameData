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
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    //sets animations for Nell so that she tends the workshop fire
    {
    if (IsInConversation(OBJECT_SELF) == FALSE && GetIsInCombat() == FALSE
        && GetLocalInt(GetModule(), "nell_animations") !=1)
        {
        ActionDoCommand(SetFacingPoint(GetPosition(GetNearestObjectByTag("wp_nell_face"))));
        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 2.0, 2.0);
        ActionPlayAnimation(ANIMATION_LOOPING_PAUSE, 2.0, 2.0);
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE, 1.0, 2.0);
        ActionWait(2.0);
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


