// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// PC given the merchant's charter. This is for flavour only.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "MC"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    CreateItemOnObject("merchantschart",oPC);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);


   //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    }

}


