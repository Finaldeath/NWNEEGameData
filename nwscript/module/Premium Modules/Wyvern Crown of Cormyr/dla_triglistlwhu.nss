// B W-Husey
// October 2005
// As the PC (only) enters, they perform a listen check using variables on the door.
// If they succeed the message is displayed in a floating string (message is also stored on the door)
// A succesful listen check yields experience, then the trigger is destroyed.
// If the PC fails to hear anything, the henchmen will then try if they are near enough.
// This one is specifically for the hut at Lake Wyvernwater.

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC)==TRUE)
    { //It was a PC that entered the trigger - proceed.
        object oDoor = GetNearestObjectByTag("LWDoorHut");
        int nTest = GetLocalInt(oDoor, "DOOR_LISTEN");
        string sMessage = GetLocalString (oDoor,"DOOR_MESSAGE");
        string sNone = "None"; //null string - we're never going to test for this one, but a value is required by the PartyGotEntry function.
        object oHench1 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,1);
        object oHench2 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,2);
        if (GetSkillCheckSucceeded(oPC,SKILL_LISTEN,nTest))
        { //Listen Skill check succesfully passed - only the first PC gets this opportunity
            PartyGotEntry(sNone,oPC,nTest*2,"XP gain - skill use");
            FloatingTextStringOnCreature("You hear something...",oPC);
            FloatingTextStringOnCreature(sMessage,oPC);
        }
        else if (oHench1 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench1)<10.0 && GetSkillCheckSucceeded(oHench1,SKILL_LISTEN,nTest))
        { //Listen Skill check for 1st henchman
            AssignCommand(oHench1,SpeakString("I heard something: " + sMessage));
        }
        else if (oHench2 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench2)<10.0 && GetSkillCheckSucceeded(oHench2,SKILL_LISTEN,nTest))
        { //Listen Skill check for 2nd henchman
            AssignCommand(oHench2,SpeakString("I heard something: " + sMessage));
        }
    DestroyObject(OBJECT_SELF);
    }
}
