// February 2006
// B W-Husey
// Sets up which barrow door goes where. First goes to treasure chambers, second to ring chamber.

#include "cu_functions"
void main()
{
    // Declare variables needed
    object oDoor = OBJECT_SELF;
    object oDestination;
    object oPC = GetEnteringObject();  //Replaced GetLastUsedBy as this returns null on a transition with no door for some reason. (Thanks Mirko/TK!)
    int nNumber = GetLocalInt(oPC,"nBarrDest");
        //************debug lines****************
//        SendMessageToPC(oPC,"Fired");

    if (nNumber < 1) //doors are not set, set them
    {
        //get all the doors so we can set their destinations.
        object oDoorWest = GetObjectByTag("HFBDown1");
        object oDoorEast = GetObjectByTag("HFBDown2");
        object oDoorFirst =  GetObjectByTag("HFBCUpFirst");
        object oDoorSecond =  GetObjectByTag("HFBCUpSecond");

        //work out what is which door
        object oOtherDoor;
        if (GetTag(oDoor) == GetTag(oDoorWest)) oOtherDoor = oDoorEast;
        if (GetTag(oDoor) == GetTag(oDoorEast)) oOtherDoor = oDoorWest;

        SetLocalString(oDoor,"sMyTarget",GetTag(oDoorFirst));
        SetLocalString(oOtherDoor,"sMyTarget",GetTag(oDoorSecond));
        SetLocalString(oDoorFirst,"sMyTarget",GetTag(oDoor));
        SetLocalString(oDoorSecond,"sMyTarget",GetTag(oOtherDoor));
        oDestination = oDoorFirst;
        AllParty("nBarrDest",oPC,1);
        //************debug lines****************
//        SendMessageToPC(oPC,"Set up doors: Me = "+GetTag(oDoor)+" Target "+GetLocalString(oDoor,"sMyTarget"));

    }
    else // doors are set, get destination of this door
    {
        oDestination = GetObjectByTag(GetLocalString(oDoor,"sMyTarget"));
    }
    AssignCommand(oPC,JumpToObject(oDestination));
}
