// January 2006
// B W-Husey
// Caladnei2 dialogue script:
// Creates squads of soldiers and sends them to their positions dependant on PC choices.
// Each squad gets orders for the duration of the battle.

#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    string sSquadLead;
    string sSquadie;
    string sTag = "Goodie";

    //The station to send the troops to is set in a prior response
    int nStation = GetLocalInt(oPC,"nBatPos");



    //Determine what squad this is
    if (GetLocalInt(oPC,"nSquadNo")==0) SetLocalInt(oPC,"nSquadNo",1);
    int nSquad = GetLocalInt(oPC,"nSquadNo");
    switch (nSquad)
    {
    case 1:
        sSquadLead = "BattlePDKC";
        sSquadie = "BattlePDKA";
    break;
    case 2:
        sSquadLead = "BattlePDKL";
        sSquadie = "BattlePDKM";
    break;
    case 3:
        sSquadLead = "BattlePDKC";
        sSquadie = "BattlePDKM";
    break;
    case 4:
        sSquadLead = "BattlePDKL";
        sSquadie = "BattlePDKM";
    break;
    case 5:
        sSquadLead = "BattleHawk";
        sSquadie = "BattleHawk";
    break;
/*    case 6:
        sSquadLead = "BattlePDKM";
        sSquadie = "BattlePDKM";
    break;*/
    }
    AllParty("nSquadNo",oPC,nSquad+1);

    //Dependant on position chosen, pick the waypoints for the squad
    object oLoc1 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"1");
    object oLoc2 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"2");
    object oLoc3 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"3");
    object oLoc4 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"4");
    object oLoc5 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"5");
    object oLoc6 = GetWaypointByTag("BatPoint"+IntToString(nStation)+"6");

    //Where the army arrives from
    location lStar1 = GetLocation(GetWaypointByTag("BatStart1"));
    location lStar2 = GetLocation(GetWaypointByTag("BatStart2"));
    location lStar3 = GetLocation(GetWaypointByTag("BatStart3"));
    location lStar4 = GetLocation(GetWaypointByTag("BatStart4"));
    location lStar5 = GetLocation(GetWaypointByTag("BatStart5"));
    location lStar6 = GetLocation(GetWaypointByTag("BatStart6"));

    //Squad first move point
    object oLocf1 = GetWaypointByTag("BatStartf1");
    object oLocf2 = GetWaypointByTag("BatStartf2");
    object oLocf3 = GetWaypointByTag("BatStartf3");
    object oLocf4 = GetWaypointByTag("BatStartf4");
    object oLocf5 = GetWaypointByTag("BatStartf5");
    object oLocf6 = GetWaypointByTag("BatStartf6");

    //Create the squad with tag = to their orders
    object o1 = CreateObject(OBJECT_TYPE_CREATURE,sSquadLead,lStar1,FALSE,sTag);
    object o2 = CreateObject(OBJECT_TYPE_CREATURE,sSquadie,lStar2,FALSE,sTag);
    object o3 = CreateObject(OBJECT_TYPE_CREATURE,sSquadie,lStar3,FALSE,sTag);
    object o4 = CreateObject(OBJECT_TYPE_CREATURE,sSquadie,lStar4,FALSE,sTag);
    object o5 = CreateObject(OBJECT_TYPE_CREATURE,sSquadie,lStar5,FALSE,sTag);
    object o6 = CreateObject(OBJECT_TYPE_CREATURE,sSquadie,lStar6,FALSE,sTag);

    //Give the squad move orders
    DelayCommand(1.0,AssignCommand(o1,ActionMoveToObject(oLocf1)));
    DelayCommand(1.0,AssignCommand(o2,ActionMoveToObject(oLocf2)));
    DelayCommand(1.1,AssignCommand(o3,ActionMoveToObject(oLocf3)));
    DelayCommand(1.1,AssignCommand(o4,ActionMoveToObject(oLocf4)));
    DelayCommand(1.2,AssignCommand(o5,ActionMoveToObject(oLocf5)));
    DelayCommand(1.2,AssignCommand(o6,ActionMoveToObject(oLocf6)));

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

    // Increment squad counter
    SetLocalInt(oPC,"nSquadNo",nSquad+1);
    if (GetLocalInt(oPC,"nSquadNo")>5) DeleteLocalInt(oPC,"nSquadNo"); //Finished with variables
}
