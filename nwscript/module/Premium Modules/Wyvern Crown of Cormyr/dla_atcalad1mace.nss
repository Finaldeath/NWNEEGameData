// April 2004
// B W-Husey
// March2006
// B W-Husey
// NPC rewards template to be used after an action
// Caladnei gives the PC the Golem Mace
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "Mace"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);

    CreateItemOnObject("golemmace",oPC);
    AllParty(sName,oPC,2);                                    //Just sets variable
    }

}


