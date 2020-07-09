// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP2"+GetTag(OBJECT_SELF);                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
//    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXP2a", oPC, "CHAOTIC", 0, 2); //Apply to specific alignment
    AligXP("AligXP2", oPC, "EVIL", 50, 1);        //Shift/reward any alignment
    }

}


