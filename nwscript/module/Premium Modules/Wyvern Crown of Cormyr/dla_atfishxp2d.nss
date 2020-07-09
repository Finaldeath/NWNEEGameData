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

    object oItem = GetItemPossessedBy(oPC,"HultailSpirits");
    AssignCommand(oPC,ActionGiveItem(oItem,OBJECT_SELF));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
    CreateItemOnObject("skillstone",oPC);

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 150);
    FloatingTextStringOnCreature("XP Gained",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    }

}


