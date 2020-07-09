//::///////////////////////////////////////////////
//:: FileName oe_ac_ckchsqst3
//:: See if player is on Cheese quest and has talked to Yentai.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/17/2005 2:02:46 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetEnteringObject();
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
if(!(GetLocalInt(oPC, "ac_cheese_quest") >= 3)) return;
SetLocalInt(OBJECT_SELF,"fired",1);
AssignCommand(GetObjectByTag("ac_porto"), ActionStartConversation(GetObjectByTag("ac_millie"), "at_porto2"));
}
