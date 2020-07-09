// B W-Husey
// September 2005
// XP for ability use
// PC now knows Huntcrown got the horn. Update Ride like a Centaur journal entry if got the quest.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "XP3"+GetTag(OBJECT_SELF);
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);
//string sName = "Stan1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 100);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());
    AllParty("nHOrder",oPC,1);
    if (GetLocalInt(oPC,"nToOrder")==1)    AddJournalQuestEntry("Order",15,oPC);
    else AddJournalQuestEntry("Order",31,oPC);
    if (GetLocalInt(oPC,"nManthia1Side")==1)
        {
        AddJournalQuestEntry("Centaur",20,oPC);
        PartyGotEntry(sName,oPC,100,"XP Gain - Discovery");  //This comes with XP & message + sets the variable
        }
    AllParty(sName,oPC,2);
    }

}








