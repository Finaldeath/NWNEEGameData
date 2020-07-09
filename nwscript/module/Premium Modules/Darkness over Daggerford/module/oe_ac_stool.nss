//::///////////////////////////////////////////////
//:: oe_ac_stool
//:: Player sits on stool triggering next node of convo
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: December 04, 2005
//:://////////////////////////////////////////////

void main()
{

  object oChair = OBJECT_SELF;
  object oPC = GetLastUsedBy();
  object oJ = GetObjectByTag("ac_jonas1");
  AssignCommand(oPC, ActionSit(oChair));
if (!(GetLocalInt(GetModule(), "ac_werewolf")>=1)) return;

if (GetLocalInt(OBJECT_SELF,"fired")==1) return;

  SetLocalInt(GetModule(),"ac_werewolf",2);
  SetLocalInt(OBJECT_SELF,"fired",1);
  DelayCommand(2.0, AssignCommand(oJ,ClearAllActions()));
  DelayCommand(2.5, AssignCommand(oJ,ActionStartConversation(oPC)));

}
