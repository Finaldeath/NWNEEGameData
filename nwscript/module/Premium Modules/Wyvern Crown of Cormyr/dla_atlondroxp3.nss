// B W-Husey
// September 2005
// XP for ability use. Got an oath out of Londro in return for a promise of better treatment from
// the Matron - recorded in TheApprenticeSlave journal: 37.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

// Section added to prevent oath options returning.
string sName = "Var7"+GetTag(OBJECT_SELF);      //Set variable to object's tag + extra bit
AllParty(sName,GetPCSpeaker(),TRUE);

sName = "XP3"+GetTag(OBJECT_SELF);
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);
//string sName = "Stan1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - use of ability",GetPCSpeaker());
    AllParty("LondroSide",oPC,10);
    PartyGotEntry(sName,oPC,100,"XP Gain - Oath extracted");
    AddJournalQuestEntry("TheApprenticeSlave",37,oPC,TRUE);
    DestroyObject(GetObjectByTag("WitnessDoc")); //if it's there, get rid of it.
    }

}








