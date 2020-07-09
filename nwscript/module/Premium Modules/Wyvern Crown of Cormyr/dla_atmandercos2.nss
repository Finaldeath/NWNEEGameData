//dla_atmandercos2
// May 2006
// B W-Husey
// Reduces the map cost by 5. Gives xp for skill use.

#include "cu_functions"

void main()
{

//Pick Variable Type and rename
string sName = "XP1"+GetTag(OBJECT_SELF);                     //Unique tag
object oPC = GetPCSpeaker();
int nGold = GetLocalInt(oPC, "nTMapCost");

//Give rewards once only
//if (GetLocalInt(oPC,sName)<1) //once only
//    {

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 100);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable

        AllParty("nTMapCost",oPC,nGold-5);
        SetCustomToken(1008,IntToString(nGold-5));

//    }

}

