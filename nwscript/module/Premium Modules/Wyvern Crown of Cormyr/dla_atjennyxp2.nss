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

    // reward goldor items
    GiveGoldToCreature(oPC,1);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);

    AligXP("AligXP2Jen", oPC, "EVIL", 25, 1);        //Shift/reward any alignment

    }

}


