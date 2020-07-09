// September 2005
// B W-Husey
// NPC rewards template to be used after an action. This particular reward also sets the state of
// TheApprenticeSlave entry to 31: The PC managed to get some gold out of Londro in exchange for
// the promise of better treatment from the Matron.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP4"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    // reward gold
    GiveGoldToCreature(oPC,17);
    AligXP("XP4bLondro", oPC, "EVIL", 25, 0);        //Shift/reward any alignment

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());
    AddJournalQuestEntry("TheApprenticeSlave",31,oPC,TRUE);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);
    }

}







