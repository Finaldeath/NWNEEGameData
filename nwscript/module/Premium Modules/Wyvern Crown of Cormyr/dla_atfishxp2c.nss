// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Fisherman gets a drink. 4 versions but only one is possible.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    object oItem = GetItemPossessedBy(oPC,"nw_it_mpotion021");
//    AssignCommand(oPC,ActionGiveItem(oItem,OBJECT_SELF));
    SetItemStackSize(oItem,GetItemStackSize(oItem)-1);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);

    // Remove from the player
//    DestroyObject(GetObjectByTag("TagXXXXX"));

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    }

}


