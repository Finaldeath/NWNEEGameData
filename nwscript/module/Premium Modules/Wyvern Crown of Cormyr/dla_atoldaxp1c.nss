// Nocember 2005
// B W-Husey
// Rejection of the damsel sidequest with threats - call the watch variation. Evil or neutral do OK
// on this one, as do lawful characters.

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
    if(GetAlignmentGoodEvil(oPC)!=ALIGNMENT_NEUTRAL)    AligXP("DamAligXP1", oPC, "EVIL",180, 1);        //Shift/reward any alignment
    else AligXP("DamAligXP1", oPC, "NEUTRAL",100, 0);
    AligXP("DamAligXP1", oPC, "LAWFUL",50, 1);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    ScoreAlign(oPC,4,2,1,0,4,2,2,4,3,3);            //Who gets alignment points for this
    }

}


