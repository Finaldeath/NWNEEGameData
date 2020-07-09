// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// PC gives head and licence to gravedigger, who makes a grave
// update journal, give xp, update variable nGrave to 3 (buried), create grave after suitable
// delay.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nGrave";                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<3) //once only
    {

    // reward goldor items
    object oItem = GetItemPossessedBy(oPC,"Licence");
    AssignCommand(oPC,ActionGiveItem(oItem,OBJECT_SELF));
    object oItem2 = GetItemPossessedBy(oPC,"FatherHead");
    AssignCommand(oPC,ActionGiveItem(oItem2,OBJECT_SELF));

    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);

    // Remove from the player
    SetPlotFlag(oItem,FALSE);
    SetPlotFlag(oItem2,FALSE);
    DestroyObject(oItem,2.0);
    DestroyObject(oItem2,2.0);

    //Alignment consequences of action
    AligXP("AligXP2Grave3", oPC, "GOOD", 25, 0);        //Shift/reward any alignment
    AligXP("AligXP2Grave3b", oPC, "LAWFUL", 25, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,3);                                    //Just sets variable
    PartyGotEntry("Dud",oPC,250,"XP Gain - father laid to rest");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Grave",30,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


