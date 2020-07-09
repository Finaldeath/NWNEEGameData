// October 2005
// B W-Husey
// The smith's fees change as a result of appraise, and the PC is rewarded xp.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

// This section deals with setting the new cost.

    int nBase = GetLocalInt(oPC,"nCraftCost");
    SetCustomToken(1011,IntToString((nBase*5)-500)+" golden lions");
    SetLocalInt(oPC,"nCraftAd",1);//special price on adamantium

//This section deals with rewards
//Pick Variable Type and rename
string sName = "Cost2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 75);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC
    SetLocalInt(oPC,sName,2);
    }

}



