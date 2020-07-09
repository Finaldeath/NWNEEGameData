//::///////////////////////////////////////////////
//:: FileName trg_ac_chest
//:: Alicine is rummaging through chest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////
void ahcFace(object o1, object o2)
{
    AssignCommand(o1, ActionDoCommand(SetFacingPoint(GetPosition(o2))));
    AssignCommand(o1, ActionStartConversation (o2));

}

void main()
{
    object oPC = GetEnteringObject();
    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
    SetLocalInt(OBJECT_SELF,"fired",1);

    AssignCommand(oPC, ClearAllActions());
    ahcFace(oPC, OBJECT_SELF);
    object oChest = GetObjectByTag("ac_plc_chest");

    object oA = GetObjectByTag("ac_alicine");
    SetLocalInt(oA,"no_banter",1);
    DelayCommand(2.4,SetLocalInt(oA,"no_banter",0));

    AssignCommand(oA, SetFacingPoint(GetPosition(oChest)));
    AssignCommand(oA, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
    DelayCommand(2.0, AssignCommand(oChest, PlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
    DelayCommand(2.5, ahcFace(oA,oPC));
}

