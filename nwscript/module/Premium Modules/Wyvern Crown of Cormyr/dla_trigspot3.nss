// B W-Husey
// November 2005
// As the PC (only) enters, they perform a SEARCH check using variables on the nearby object.
// If they succeed the message is displayed in a floating string (message is also stored on the object)
// A succesful SEARCH check yields experience. If the PC fails to spot anything, the henchmen will then try if they are near enough.
// This one is for the To be a Spy sidequest and requires the quest to be under way.

// Ammended to use search

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    /*can only find the door if
        not done a deal with Hawklin
        not found it already
        actively searching (or an elf)
        Kathryn is not in the party
    */
    if (GetIsDefPC(oPC)==TRUE
        && GetLocalInt(oPC,"nSpy")==1
        && (GetDetectMode(oPC)==DETECT_MODE_ACTIVE || GetRacialType(oPC)==RACIAL_TYPE_ELF)
        && GetInParty("Kathryn", oPC)==FALSE)
    { //It was a PC that entered the trigger - proceed.
        int nSpotted = 0; //track whether spot object got seen.
        object oDoor = GetNearestObjectByTag("dla_spotobject");
        int nTest = GetLocalInt(oDoor, "OBJECT_SPOT");
        string sMessage = GetLocalString (oDoor,"OBJECT_MESSAGE");
        string sNone = "None"; //null string - we're never going to test for this one, but a value is required by the function.
        object oHench1 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,1);
        object oHench2 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,2);
        if (GetSkillCheckSucceeded(oPC,SKILL_SEARCH,nTest))
        { //Search Skill check succesfully passed - only the first PC gets this opportunity
            FloatingTextStringOnCreature("You notice something..."+sMessage,oPC);
//            FloatingTextStringOnCreature(sMessage,oPC);
            PartyGotEntry(sNone,oPC,nTest*5,"XP gain - skill use");
            nSpotted = 1;
        }
        else if (oHench1 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench1)<10.0 && GetSkillCheckSucceeded(oHench1,SKILL_SEARCH,nTest))
        { //Search Skill check for 1st henchman
            AssignCommand(oHench1,SpeakString("Look!: " + sMessage));
            nSpotted = 1;
        }
        else if (oHench2 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench2)<10.0 && GetSkillCheckSucceeded(oHench2,SKILL_SEARCH,nTest))
        { //Search Skill check for 2nd henchman
            AssignCommand(oHench2,SpeakString("Look!: " + sMessage));
            nSpotted = 1;
        }
        if (nSpotted = 1)
        {
        AllParty("nSpy",oPC,3);
        AllParty("nDoorSeen",oPC,1); // a special variable in case I want to use it for conversations (sell the secret)
        }
        else AllParty("nSpy",oPC,2);
    }
}
