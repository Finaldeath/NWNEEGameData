//con_ac_y_reward
//Give PC reward for helping Millie escape
//Author: Alan Tarrant
//Date: December 18, 2005

void main()
{
    int iR = GetLocalInt(OBJECT_SELF, "yentai_reward");
    object oPC = GetPCSpeaker();
    GiveGoldToCreature(oPC,iR);
}
