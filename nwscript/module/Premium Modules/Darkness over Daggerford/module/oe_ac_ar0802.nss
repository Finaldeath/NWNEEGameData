//::///////////////////////////////////////////////
//:: FileName oe_ac_ar0802
//:: Player makes observation about door
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/27/2005 12:43:18 AM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetEnteringObject();
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
SetLocalInt(OBJECT_SELF,"fired",1);

AssignCommand(oPC, SpeakString("The door seems to have been forced open from the inside."));
}
