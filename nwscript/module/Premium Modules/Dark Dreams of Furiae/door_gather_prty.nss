//::///////////////////////////////////////////////////////////////
//:: Name - Baldur's Gate Style Forced Simultaneous Area Transition
//:: FileName - gatherparty
//:: Copyright (c) Jeremy Sager
//::///////////////////////////////////////////////////////////////
/*
This script will force the entire party to be close together
in order to effect an area transition and it will take the
entire party all at once to the new area.
If the party is not close enough together, then the door will
float a string overhead saying "You must gather your party
before venturing forth" or whatever you want it to say.
This script was designed with the idea of a one party server
without respawn. Dead members will be left behind...
hopefully their mates will be able to ressurect them.
The script should be put in the "OnAreaTransitionClick" spot.
Make sure you change the Tag of the location lDestination to
the tag of the door or waypoint you want them to go to.
For other easily changeable things, check the in-script comments.
Last but not least, if you improve upon this script, email me and
let me know! I'll probably want to use your version ^_^
*/
//:://////////////////////////////////////////////
//:: Created By: Jeremy Sager (Jeremy_21117@hotmail.com)
//:: Created On: July 6th 2002
//:://////////////////////////////////////////////
void main()
{
    object oFirstMember = GetClickingObject(); //Gets the first member of the party
    object oPartyMember = GetFirstFactionMember(oFirstMember, TRUE); //Gets the second member of the party if there is one.
    string sDestTag = "DST_" + GetTag(OBJECT_SELF);
    location lDestination= GetLocation(GetTransitionTarget(OBJECT_SELF));// GetLocation(GetObjectByTag(sDestTag)); // Set the tag to your destination's tag.
    while (GetIsObjectValid (oPartyMember)) // This will loop until all party members are accounted for.
        {
        if (!GetIsDead (oPartyMember)) // Dead members will be skipped
            {
            int iDistanceCheck = FloatToInt (GetDistanceToObject (oPartyMember));
            if (iDistanceCheck > 10) // Check to see if oPartyMember is within 10 meters. If not, send the message and exit the script without transition.
                {
                ActionSpeakString ("You must gather your party before venturing forth", TALKVOLUME_TALK);
                return;
                }
            }
        oPartyMember = GetNextFactionMember (oFirstMember, TRUE); //Set oPartyMember to the next person in the party.
        }
    // If you've made it to here, everyone is within 10 meters, now time to jump to location.
    // We're going to have to scroll through the list again to do it.
    oPartyMember = GetFirstFactionMember (oFirstMember, TRUE); //Start the list over again
    while (GetIsObjectValid (oPartyMember)) // This will loop until all party members are accounted for.
        {
        if (!GetIsDead (oPartyMember)) // Dead members will be skipped
            {
            // Send the party member to the destination
            AssignCommand(oPartyMember, ClearAllActions());
            AssignCommand(oPartyMember, JumpToLocation (lDestination));
            }
        oPartyMember = GetNextFactionMember (oFirstMember, TRUE); //Set oPartyMember to the next person in the party.
        }
    // Last but not least, send the PC who clicked in the first place.
    // The script will go here right away if the party only has one person in it.
    AssignCommand(oFirstMember, ClearAllActions());
    AssignCommand(oFirstMember, JumpToLocation (lDestination));
}
