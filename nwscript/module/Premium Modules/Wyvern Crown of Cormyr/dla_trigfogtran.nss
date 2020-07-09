// January 2006
// B W-Husey
// Stes the transition location dependant on whether there is fog or not.

void main()
{
    object oPC = GetEnteringObject();

    if (GetLocalInt(oPC,"nFirstLWArea")>1) AssignCommand(oPC,JumpToObject(GetWaypointByTag("WP_CWEast")));
    else AssignCommand(oPC,JumpToObject(GetWaypointByTag("WP_CWDud")));

}
