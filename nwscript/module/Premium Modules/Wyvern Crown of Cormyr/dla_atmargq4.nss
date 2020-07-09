// January 2006
// B W-Husey
// PC takes Eleanor back to Furniture's Fate. Fade to black, update journal
// jump both objects, gain xp. Start Margery's conversation

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();
object oEl = GetObjectByTag("Eleanor");
object oWay = GetWaypointByTag("WP_DeliverE");
object oMarg = GetObjectByTag("Margery");

//Pick Variable Type and rename

string sName = "LBDud4";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    FadeToBlack(oPC);
    //Set variable for PC or partywide/update quest
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nAbduct",oPC,4);                                    //Just sets plot variable
    PartyGotEntry(sName,oPC,100,"XP Gain - quest experience");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Abduct",35,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,2,2,2,1,2,1,1,2,2,2);            //Who gets alignment points for this

    //Go to Furntiure's Fate
    DelayCommand(4.0,FadeFromBlack(oPC,FADE_SPEED_SLOW));
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oEl,JumpToObject(oWay));
    AssignCommand(oPC,JumpToObject(oWay));
    AssignCommand(oPC,ActionStartConversation(oMarg));

    }

}


