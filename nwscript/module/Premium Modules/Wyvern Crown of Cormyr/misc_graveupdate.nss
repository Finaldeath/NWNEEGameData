// December 2005/March 2006
// B W-Husey
// This script is executed from the Thunderstone: Town entry script.
// Updates the status of the Family Grave quest, depending on previous state.

#include "cu_functions"
void main()
{
        object oPC = OBJECT_SELF;
        // All below is for the Family Grave quest

        //Father's grave needs to be 'rebuilt'
        if (GetLocalInt(oPC,"nGrave")==6 || GetLocalInt(oPC,"nGrave")==9) // replace father's grave if ordered from gravedigger
        {
            if (GetLocalInt(oPC,"nNoGrave")==1)//check it's defaced (i.e. once only)
            {
            location lLoc = GetLocation(GetWaypointByTag("WP_GraveCoffin"));
            DelayCommand(30.0,DestroyObject(GetObjectByTag("Grave2")));
            DelayCommand(30.0,DestroyObject(GetObjectByTag("GraveSt")));
            DelayCommand(35.0,ActionCreatePlace("grave1",lLoc));
            AllParty("nNoGrave",oPC,2);  //switch off grave replacement routines
            }
        }
        //Father's grave has been built (1st time)
        else if (GetLocalInt(oPC,"nGrave")==4) // deface father's grave and spawn the naughty knight
        {
            // Grave has not been physically changed yet, PC has been to barrows - time to deface it.
            if (GetLocalInt(oPC,"nNoGrave")==0 && GetLocalInt(oPC,"nMainPlot")>2)
            {
                //Change the grave
                location lLoc = GetLocation(GetWaypointByTag("WP_GraveCoffin"));
                location lLoc2 = GetLocation(GetWaypointByTag("WP_GraveStones"));
                DestroyObject(GetObjectByTag("Grave1"));
                DelayCommand(5.0,ActionCreatePlace("grave2",lLoc));
                DelayCommand(2.0,ActionCreatePlace("plc_stones",lLoc2,"GraveSt"));
                AllParty("nNoGrave",oPC,1);
                //Make the knight, dismount him.
                string sResref = GetLocalString(oPC,"DLA_JoustLoser");//jouster's resref stored from the joust
                location lSpawn = GetLocation(GetWaypointByTag("WP_BadKnight"));
                object oBad = CreateObject(OBJECT_TYPE_CREATURE,sResref,lSpawn,FALSE,"BadKnight");
                DLA_Dismount(oBad,FALSE);
            }
        }
        // Father's grave has not yet been built
        else if (GetLocalInt(oPC,"nGrave")==3) //build father's grave
        {
            location lLoc = GetLocation(GetWaypointByTag("WP_GraveCoffin"));
            AllParty("nGrave",oPC,4);
            DelayCommand(30.0,ActionCreatePlace("grave1",lLoc));
        }

}
