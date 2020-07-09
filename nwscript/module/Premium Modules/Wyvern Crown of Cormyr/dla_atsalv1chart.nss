// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "Salv1MCGiven";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);
    CreateItemOnObject("merchantschart",oPC);
    }

}


