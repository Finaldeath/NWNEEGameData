// October 2005
// B W-Husey
// Sidequest script used on Magnus for the Poltergeist of Polter's Fort sidequest
// Variable is nPoltergeist, journal tag is Poltergeist
// Variable states:
// 1 = Heard of the poltergeist and offered solution
// 2 = Got the Holy Water
#include "cu_functions"

void CreatIt(object oPC)
{
CreateItemOnObject("sholywater",oPC);
}

void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nSHWaters";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    float fDelay;
    ActionPauseConversation();
    //Some animations/effects for the water
    ActionMoveToObject(oPC,FALSE,0.6);
    DelayCommand(fDelay+=1.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_FIREBRAND,OBJECT_SELF)));
    DelayCommand(fDelay+=3.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_DISPEL_MAGIC,OBJECT_SELF)));
    DelayCommand(fDelay+=3.0,AssignCommand(OBJECT_SELF,ActionCastFakeSpellAtObject(SPELL_CURE_LIGHT_WOUNDS,OBJECT_SELF)));
    DelayCommand(fDelay+=3.0,AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0)));
    DelayCommand(fDelay+=1.0,CreatIt(oPC));

//    ActionGiveItem(oItem,oPC);
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,150,"XP Gain - Fort researched");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Poltergeist",15,oPC,TRUE);                      //Update the journal
    AllParty("nPoltergeist",oPC,2);  //set the variable (PartyGotEntry sets it to 1 by default)
    DelayCommand(fDelay+=1.0,ActionResumeConversation());

    }

}




