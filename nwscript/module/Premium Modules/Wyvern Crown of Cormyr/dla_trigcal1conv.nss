// January 2006
// B W-Husey
// Creates the instances of Caladnei and Hawklin used for module section 7 (caladnei1 and hawklin3)
// Was on area, now on a trigger.

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    //make sure we got a PC in the correct stage of the mod.
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nMainPlot")==7 && GetLocalInt(oPC,"n7Done")<1 && GetLocalInt(oPC,"nPoisonedByBK")>0)
    {
        location lLoc1 = GetLocation(GetWaypointByTag("WP_Caladnei1Here"));
        location lLoc2 = GetLocation(GetWaypointByTag("WP_Hawklin3Here"));
        object oCal = CreateObject(OBJECT_TYPE_CREATURE,"caladnei",lLoc1,FALSE,"Caladnei1");
        CreateObject(OBJECT_TYPE_CREATURE,"sirgilbert002",lLoc1,FALSE,"SGHFinal");
        AllParty("n7Done",oPC,1);
        AssignCommand(oCal,DelayCommand(1.0,ActionStartConversation(oPC,"caladnei1",FALSE,FALSE)));
        FadeFromBlack(oPC);
        SetCutsceneMode(oPC, FALSE);
    }
}
