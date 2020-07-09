// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC intimidates the Witch Lord and gets a magic item. It is a wizard item, giving a clue to
// the nature of the Witch Lord (though it may not be that useful)

#include "cu_functions"
#include "cu_treasure"
#include "cu_magicspecific"

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
    GetTreasure("Gold10",oPC,100,10*d10());
    GetTreasureType("Wizardry",oPC,100,2,1);
    CreateItemOnObject("enchantingstone",oPC);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);


    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 100);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    }

}


