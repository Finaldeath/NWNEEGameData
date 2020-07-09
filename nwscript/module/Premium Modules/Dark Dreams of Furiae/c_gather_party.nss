#include "ddf_util"

int StartingConditional()
{

    object oFirstMember = GetPCSpeaker();// GetClickingObject(); //Gets the first member of the party
    object oPartyMember = GetFirstFactionMember(oFirstMember, TRUE); //Gets the second member of the party if there is one.
    //string sDestTag = "DST_" + GetTag(OBJECT_SELF);
    //location lDestination= GetLocation(GetTransitionTarget(OBJECT_SELF));// GetLocation(GetObjectByTag(sDestTag)); // Set the tag to your destination's tag.
    while (GetIsObjectValid (oPartyMember)) // This will loop until all party members are accounted for.
    {
        if (!GetIsDead (oPartyMember)) // Dead members will be skipped
        {
            int iDistanceCheck = FloatToInt (GetDistanceToObject (oPartyMember));
            if (iDistanceCheck > GATHER_PARTY_DISTANCE) // Check to see if oPartyMember is within 10 meters. If not, send the message and exit the script without transition.
            {
                return TRUE;
                //ActionSpeakString ("You must gather your party before venturing forth", TALKVOLUME_TALK);
                //return;
            }
        }
        oPartyMember = GetNextFactionMember (oFirstMember, TRUE); //Set oPartyMember to the next person in the party.
    }

    return FALSE;
}
