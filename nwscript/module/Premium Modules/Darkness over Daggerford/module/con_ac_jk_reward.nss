//con_ac_jk_reward
//Give PC reward for helping Jouka.
//Author: Alan Tarrant
//Date: April 9, 2006

void main()
{
object oPC = GetPCSpeaker();
object oItemToTake = GetItemPossessedBy(oPC, "ac_joukasawl");
int iR = GetLocalInt(oPC, "ac_joukareward");
SetLocalInt(OBJECT_SELF, "ac_jouka_quest", 3);
GiveGoldToCreature(oPC,iR);
//Take the awl
if(GetIsObjectValid(oItemToTake) != 0)
DestroyObject(oItemToTake);
GiveXPToCreature(GetPCSpeaker(),250);
}
