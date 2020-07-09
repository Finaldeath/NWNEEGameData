// Nocember 2005
// B W-Husey
// Rejection of the damsel sidequest with threats - don't have time variation. Evil or chaotic neutral do OK
// on this one

#include "cu_functions"

void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "AXP1"+GetTag(OBJECT_SELF);                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    if(GetAlignmentGoodEvil(oPC)!=ALIGNMENT_NEUTRAL)    AligXP("DamAligXP1", oPC, "EVIL",200, 2);        //Shift/reward any alignment
    else AligXP("DamAligXP1", oPC, "NEUTRAL",200, 1);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    ScoreAlign(oPC,4,0,0,0,1,2,4,3,4,4);            //Who gets alignment points for this
    }

}


