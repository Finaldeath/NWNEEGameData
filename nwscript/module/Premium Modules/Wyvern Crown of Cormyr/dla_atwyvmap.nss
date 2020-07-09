// January 2006
// B W-Husey
// Wyvernvapor gives the PC the map (which he can't actually read). Update journal and give.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "Map"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
//    GiveGoldToCreature(oPC,1);
      object oItem = GetItemPossessedBy(OBJECT_SELF,"BarrowMap");
      ActionGiveItem(oItem,oPC);
      ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);

    //Set variable for PC or partywide
      AllParty(sName,oPC,2);                                    //Just sets variable
      PartyGotEntry(sName,oPC,500,"XP Gain - located crown?");  //This comes with XP & message + sets the variable
      AddJournalQuestEntry("MainPlot",90,oPC,TRUE);                      //Update the journal
    }

}


