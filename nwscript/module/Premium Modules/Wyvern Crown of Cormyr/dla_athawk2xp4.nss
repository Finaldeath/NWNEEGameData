// December 2005
// B W-Husey
// NPC rewards template to be used after an action
//

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP4"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,100,"XP Gain - Hawklin updated on pirates");  //This comes with XP & message + sets the variable
    }

}


