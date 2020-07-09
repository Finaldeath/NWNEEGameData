// dla_doortran3
// February 2006
// B W-Husey
// Sets up which 'On the road' area links to the bandit camp.

#include "cu_functions"
void main()
{
    // Declare variables needed
    object oDoor = OBJECT_SELF;
    object oPC = GetEnteringObject();  //Replaced GetLastUsedBy as this returns null on a transition with no door for some reason. (Thanks Mirko/TK!)
    object oDestination = GetTransitionTarget(OBJECT_SELF);
    int nNumber = GetLocalInt(oPC,"nOTRDest");
        //************debug lines****************
//        SendMessageToPC(oPC,"Fired");

    if (nNumber < 1) //doors are not set, set them
    {
        object oDoorSecond =  GetObjectByTag("OTRCSouth");

        SetLocalString(oDoorSecond,"sMyTarget",GetTag(OBJECT_SELF));
        AllParty("nOTRDest",oPC,1);
        //************debug lines****************
//        SendMessageToPC(oPC,"Set up doors: Me = "+GetTag(oDoor)+" Target "+GetLocalString(oDoor,"sMyTarget"));

    }

    AssignCommand(oPC,JumpToObject(oDestination));
    DLA_SetAreaTransCameraFacing(oPC,oDestination);
}
