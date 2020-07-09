// Nocember 2005
// B W-Husey
// Took damsel quest, but scarpered. Evil or neutral do OK on this one, good characters less so.
// Set journal and completed variable

#include "cu_functions"

void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "AXP2"+GetTag(OBJECT_SELF);                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL)    AligXP("DamAligXP2", oPC, "EVIL",50, 0);        //Shift/reward any alignment
    else AligXP("DamAligXP2", oPC, "NEUTRAL",50, 1);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nDamsel",oPC,11);                                    //Just sets variable
    AddJournalQuestEntry("Damsel",22,oPC,TRUE);                      //Update the journal
    GiveKnightReputation(oPC,"the Cautious");
    ScoreAlign(oPC,4,1,2,1,3,4,4,3,4,4);            //Who gets alignment points for this
    }

}


