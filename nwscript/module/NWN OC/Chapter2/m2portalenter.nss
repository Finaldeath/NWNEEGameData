//::///////////////////////////////////////////////
//:: Conversation
//:: M2PortalEnter
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Signals the portal enter event.
*/
//:://////////////////////////////////////////////
//:: Created By: John Winski
//:: Created On: April 29, 2002
//:://////////////////////////////////////////////

void main()
{
    SignalEvent(OBJECT_SELF,EventUserDefined(100));
}