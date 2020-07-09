// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC intimidates the Witch Lord and fails. Gold only.

#include "cu_functions"
#include "cu_treasure"

void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP1"+GetTag(OBJECT_SELF);                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    GetTreasure("Gold",oPC,100,10*d10(),10);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    }

}


