void main()
{
object oPC = GetLastUsedBy();
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
SetLocalInt(OBJECT_SELF,"fired",1);
AssignCommand(oPC,SpeakString("These footprints lead towards the crypt door."));
}
