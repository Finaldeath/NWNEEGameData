//con_ac_y_rwd250
//Give PC 250 gold pieces for killing Yentai; set variable for remaining amount.
//Author: Alan Tarrant
//Date: December 18, 2005

void main()
{
object oPC = GetPCSpeaker();
GiveGoldToCreature(oPC,250);
SetLocalInt (OBJECT_SELF, "yentai_reward",750);
}
