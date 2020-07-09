// January 2006
// B W-Husey
// Battle leader dialogue script:
// Changes the position of the squad

#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    string sSquadLead;
    string sSquadie;
    string sTag = "Goodie";

    //The station to send the troops to is set in a prior response
    int nStation = GetLocalInt(oPC,"nBatPos");

    //Get the right squad - needs revision to avoid squad mix ups
    object o1 = OBJECT_SELF;
    object o2 = GetNearestObjectByTag("Goodie",OBJECT_SELF,5);
    object o3 = GetNearestObjectByTag("Goodie",OBJECT_SELF,4);
    object o4 = GetNearestObjectByTag("Goodie",OBJECT_SELF,3);
    object o5 = GetNearestObjectByTag("Goodie",OBJECT_SELF,2);
    object o6 = GetNearestObjectByTag("Goodie",OBJECT_SELF,1);


    //Dependant on position chosen, pick the waypoints for the squad
    object oLoc1 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"1");
    object oLoc2 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"2");
    object oLoc3 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"3");
    object oLoc4 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"4");
    object oLoc5 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"5");
    object oLoc6 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"6");

    DelayCommand(3.0,AssignCommand(o1,ActionForceMoveToObject(oLoc1,FALSE,0.0,15.0)));
    DelayCommand(3.0,AssignCommand(o2,ActionForceMoveToObject(oLoc2,FALSE,0.0,15.0)));
    DelayCommand(3.1,AssignCommand(o3,ActionForceMoveToObject(oLoc3,FALSE,0.0,15.0)));
    DelayCommand(3.1,AssignCommand(o4,ActionForceMoveToObject(oLoc4,FALSE,0.0,15.0)));
    DelayCommand(3.2,AssignCommand(o5,ActionForceMoveToObject(oLoc5,FALSE,0.0,15.0)));
    DelayCommand(3.2,AssignCommand(o6,ActionForceMoveToObject(oLoc6,FALSE,0.0,15.0)));

    //ORDERS Section - store required object for soldier to retreat to if ordered.
    SetLocalString(o1,"Post",GetTag(oLoc1));
    SetLocalString(o2,"Post",GetTag(oLoc2));
    SetLocalString(o3,"Post",GetTag(oLoc3));
    SetLocalString(o4,"Post",GetTag(oLoc4));
    SetLocalString(o5,"Post",GetTag(oLoc5));
    SetLocalString(o6,"Post",GetTag(oLoc6));

}
