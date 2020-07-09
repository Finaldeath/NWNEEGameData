// February 2006
// B W-Husey
// NPC rewards template to be used after an action
// Gnome item XP

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP3"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {


    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - correct choice",GetPCSpeaker());
        object oItem = CreateItemOnObject("spellmantle",oPC);
        SetIdentified(oItem,TRUE);
    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    }

}


