// Nocember 2005
// B W-Husey
// Rejection of the damsel sidequest with threats - this one is the best evil solution. Give adequate
// XP for not doing the quest.
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
    AligXP("DamAligXP1", oPC, "EVIL", 250, 3);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    ScoreAlign(oPC,4,0,0,0,0,0,0,3,4,4);            //Who gets alignment points for this
    }

}


