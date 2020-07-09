void main()
{
object oPC = GetEnteringObject();
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF,"do_once")==1) return;
if (GetLocalInt(oPC,"nIH_KnowsExit")==1)
{
CreateObject(OBJECT_TYPE_PLACEABLE, "ac_trans_sarco", GetLocation(GetObjectByTag("wp_ac_sarco1")));
CreateObject(OBJECT_TYPE_PLACEABLE, "ac_trans_sarco", GetLocation(GetObjectByTag("wp_ac_sarco2")));
SetLocalInt(OBJECT_SELF,"do_once",1);
}
}
