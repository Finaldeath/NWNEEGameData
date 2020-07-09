//con_ac_takegp500
//Take 500 gold pieces from player
//Author: Anya Clancy
//Date: Oct 15, 2005

void main()
{
object oPC = GetPCSpeaker();
TakeGoldFromCreature(500, oPC);
SetLocalInt(oPC,"ac_davey_quest",2);
}
