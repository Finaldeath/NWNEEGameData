// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// PC has got the horn out of Magnus. Reward with xp and the horn.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "GotHorn"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
      CreateItemOnObject("unicornhorn",oPC);
      ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);

    // Remove from the player
    int nGold = GetLocalInt(oPC,"nHornGold");
    if (nGold>0) TakeGoldFromCreature(nGold, oPC, FALSE); // if the PC paid for the horn, take the gold

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,100,"XP Gain - Horn recovered");  //This comes with XP & message + sets the variable
    AllParty("nToOrder",oPC,2);
    }
}


