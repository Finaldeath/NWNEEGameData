//con_ac_y_rwd200
//Give PC 200 gold pieces for killing Yentai; set variable for remaining amount.
//Author: Alan Tarrant
//Date: December 18, 2005

void main()
{
object oPC = GetPCSpeaker();
GiveGoldToCreature(oPC,200);
SetLocalInt (OBJECT_SELF, "yentai_reward",600);
}
