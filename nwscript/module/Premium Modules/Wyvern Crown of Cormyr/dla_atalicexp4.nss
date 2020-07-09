// B W-Husey
// December 2005
// XP for ability use
// PC now knows Huntcrown got the horn. Update Ride like a Centaur journal entry if got the quest.
// This one is actually in horn1 triggered dialogue

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "XP4"+GetTag(OBJECT_SELF);
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);
//string sName = "Stan1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    AllParty("nHOrder",oPC,2);
    AddJournalQuestEntry("Order",16,oPC);
    if (GetLocalInt(oPC,"nManthia1Side")==1)
        {
        AddJournalQuestEntry("Centaur",21,oPC);
        PartyGotEntry(sName,oPC,100,"XP Gain - Discovery");  //This comes with XP & message + sets the variable
        }
    AllParty(sName,oPC,2);
    }

}








