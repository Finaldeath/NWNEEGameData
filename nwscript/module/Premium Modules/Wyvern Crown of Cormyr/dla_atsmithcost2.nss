// October 2005
// B W-Husey
// The smith's fees change as a result of persuade, and the PC is rewarded xp.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

// This section deals with setting the new cost.

    int nBase = GetLocalInt(oPC,"nCraftCost");
    nBase = nBase - 100;
    int nSpecial;
    if (GetLocalInt(oPC,"nCraftAd")==1)    nSpecial = 500;  //deduct 500 from the adamantium price if this discount already agreed.
    SetCustomToken(1010,IntToString(nBase)+" golden lions");
    SetCustomToken(1011,IntToString((nBase*5)-nSpecial)+" golden lions");
    SetLocalInt(oPC,"nCraftCost",nBase);

//This section deals with rewards
//Pick Variable Type and rename
string sName = "Cost1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC
    SetLocalInt(oPC,sName,2);
    }

}



