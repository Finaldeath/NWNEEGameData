//::///////////////////////////////////////////////
//:: Name nud_a0_orcguard
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    User Defined events for the Orc Guard in the
    Twenty in a Quiver.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_HEARD_BARK = 3000;

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARD_BARK) //HEARTBEAT
    {

    }
}


