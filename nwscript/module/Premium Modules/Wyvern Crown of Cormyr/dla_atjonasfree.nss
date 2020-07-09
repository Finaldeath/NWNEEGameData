//B W-Husey
// Jonas has been freed of the Witch Ring. Good characters are expected to do this.

#include "cu_functions"
void main()
{
string sName = "j45"+GetTag(OBJECT_SELF);                     //Unique tag
object oPC = GetPCSpeaker();
//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    // reward goldor items
    GiveGoldToCreature(oPC,1);
    object oItem = GetItemPossessedBy(OBJECT_SELF,"TheWitchRing");
      SetPlotFlag(oItem,FALSE);
      DestroyObject(oItem);

    //Alignment consequences of action
    AligXP("AligXP1FreeJonas", oPC, "GOOD", 100, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    SetLocalInt(OBJECT_SELF, "nFree", 1); //Jonas is free of the ring
    PartyGotEntry(sName,oPC,500,"XP Gain - Jonas freed of Witch Lord's powers");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("QRing",45,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,10,10,10,10,5,10,10,5,5,5);            //Who gets alignment points for this
    }

}


