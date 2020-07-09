// February 2006
// B W-Husey
// NPC rewards template to be used after an action
// Alice has been hired to find information on Polter's Fort.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "Info"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nInfoDay",oPC,GetCalendarDay());
    AllParty("nInfoHour",oPC,GetTimeHour());
    }

}


