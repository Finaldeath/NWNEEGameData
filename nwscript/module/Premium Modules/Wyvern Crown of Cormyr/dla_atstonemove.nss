// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,250,"XP Gain - stone shifted");  //This comes with XP & message + sets the variable
//    AddJournalQuestEntry("",1,oPC,TRUE);                      //Update the journal
    }
object oSound = GetNearestObjectByTag("Playsound");
SoundObjectPlay(oSound);
location lLoc =GetLocation(GetWaypointByTag("WP_MovedStone"));
DestroyObject(GetObjectByTag("CWTPStones"),0.1);
DestroyObject(GetObjectByTag("Scuffs"),0.1);
CreateObject(OBJECT_TYPE_PLACEABLE,"bridgeboulder",lLoc);
DestroyObject(OBJECT_SELF);

}


