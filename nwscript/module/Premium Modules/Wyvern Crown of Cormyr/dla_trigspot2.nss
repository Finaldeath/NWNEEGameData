// B W-Husey
// August 2005
// As the PC (only) enters, they perform a spot check using variables on the nearby object.
// If they succeed the message is displayed in a floating string (message is also stored on the object)
// A succesful spot check yields experience. If the PC fails to spot anything, the henchmen will then try if they are near enough.
// This one makes a coin on the ground.

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC)==TRUE)
    { //It was a PC that entered the trigger - proceed.
        object oDoor = GetNearestObjectByTag("dla_spotobject"); //although it doesn't have to be a door!
        location lLoc = GetLocation(GetNearestObjectByTag("WP_Coin"));
        int nTest = GetLocalInt(oDoor, "OBJECT_SPOT");
        string sMessage = GetLocalString (oDoor,"OBJECT_MESSAGE");
        string sNone = "None"; //null string - we're never going to test for this one, but a value is required by the function.
        object oHench1 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,1);
        object oHench2 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,2);
        if (GetSkillCheckSucceeded(oPC,SKILL_SPOT,nTest))
        { //Listen Skill check succesfully passed - only the first PC gets this opportunity
            FloatingTextStringOnCreature("You notice something..."+sMessage,oPC);
//            FloatingTextStringOnCreature(sMessage,oPC);
            PartyGotEntry(sNone,oPC,nTest*2,"XP gain - skill use");
            CreateObject(OBJECT_TYPE_PLACEABLE,"coin",lLoc,FALSE);
        }
        else if (oHench1 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench1)<10.0 && GetSkillCheckSucceeded(oHench1,SKILL_SPOT,nTest))
        { //Listen Skill check for 1st henchman
            AssignCommand(oHench1,SpeakString("Look!: " + sMessage));
            CreateObject(OBJECT_TYPE_PLACEABLE,"coin",lLoc,FALSE);
        }
        else if (oHench2 != OBJECT_INVALID && GetDistanceBetween(oPC,oHench2)<10.0 && GetSkillCheckSucceeded(oHench2,SKILL_SPOT,nTest))
        { //Listen Skill check for 2nd henchman
            AssignCommand(oHench2,SpeakString("Look!: " + sMessage));
            CreateObject(OBJECT_TYPE_PLACEABLE,"coin",lLoc,FALSE);
        }
    DestroyObject(OBJECT_SELF);
    }
}
