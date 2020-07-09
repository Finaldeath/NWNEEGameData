void main()
{
object oPC = GetEnteringObject();
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
SetLocalInt(OBJECT_SELF,"fired",1);
location l1 = GetLocation(GetObjectByTag("wp_ac_dust1"));
location l2 = GetLocation(GetObjectByTag("wp_ac_dust2"));
location l3 = GetLocation(GetObjectByTag("wp_ac_dust3"));
CreateObject(OBJECT_TYPE_PLACEABLE, "ac_dustcloud", l1);
CreateObject(OBJECT_TYPE_PLACEABLE, "ac_dustcloud", l2);
CreateObject(OBJECT_TYPE_PLACEABLE, "ac_dustcloud", l3);
}
