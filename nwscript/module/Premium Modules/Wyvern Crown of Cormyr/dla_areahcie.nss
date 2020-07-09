// February 2006
// B W-Husey
// Makes Kathryn when the plot has advanced enough.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    DisarmParty(oPC);
    if (GetIsDefPC(oPC))
    {
        if (GetLocalInt(oPC,"nKatMade")<1 &&  GetLocalInt(oPC,"nMainPlot")>2)
        {
        location lLoc = GetLocation(GetWaypointByTag("Hench_Kathryn"));
        CreateObject(OBJECT_TYPE_CREATURE,"kathryn",lLoc,FALSE);
        AllParty("nKatMade",oPC,1);
        }
    }
}
