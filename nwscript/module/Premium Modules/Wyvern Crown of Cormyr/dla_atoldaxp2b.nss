// Nocember 2005
// B W-Husey
// Took damsel quest, and slew damsel. This is mostly good motivated, so they do best from this result,
// though evil still get a score (maybe motivated by reward)

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
    if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD)    AligXP("DamAligXP2", oPC, "GOOD",80, 1);        //Shift/reward any alignment
    else AligXP("DamAligXP2", oPC, "NEUTRAL",50, 0);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nDamsel",oPC,11);                                    //Just sets variable
    AddJournalQuestEntry("Damsel",42,oPC,TRUE);                      //Update the journal
    GiveKnightReputation(oPC,"the Brave");
    ScoreAlign(oPC,4,4,4,4,4,2,1,1,1,1);            //Who gets alignment points for this
    }

}


