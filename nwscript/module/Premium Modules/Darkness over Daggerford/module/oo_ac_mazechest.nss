//::///////////////////////////////////////////////
//:: FileName oo_ac_mazechest
//:: Put two random basic armor or weapon pieces in chest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/10/2005 9:39:14 PM
//:://////////////////////////////////////////////
void main()
{

if (GetLocalInt(OBJECT_SELF, "NW_DO_ONCE") != 0)
    return;

SetLocalInt(OBJECT_SELF, "NW_DO_ONCE", 1);

object o1;
object o2;

switch (Random(16)+1)
{
case 1:
o1 = CreateItemOnObject("nw_wswss001", OBJECT_SELF, 1);
break;
case 2:
o1 = CreateItemOnObject("nw_wswls001", OBJECT_SELF, 1);
break;
case 3:
o1 = CreateItemOnObject("nw_wblmcl002", OBJECT_SELF, 1);
break;
case 4:
o1 = CreateItemOnObject("nw_wamar001", OBJECT_SELF, 99);
o2 = CreateItemOnObject("nw_wbwsh001", OBJECT_SELF, 1);
break;
case 5:
o1 = CreateItemOnObject("nw_wamar001", OBJECT_SELF, 99);
o2 = CreateItemOnObject("nw_wbwln001", OBJECT_SELF, 1);
break;
case 6:
o1 = CreateItemOnObject("nw_wambu001", OBJECT_SELF, 99);
o2 = CreateItemOnObject("nw_wbwsl001", OBJECT_SELF, 1);
break;
case 7:
o1 = CreateItemOnObject("nw_waxmhn002", OBJECT_SELF, 1);
break;
case 8:
o1 = CreateItemOnObject("nw_waxbt001", OBJECT_SELF, 1);
break;
case 9:
o1 = CreateItemOnObject("nw_aarcl012", OBJECT_SELF, 1);
break;
case 10:
o1 = CreateItemOnObject("nw_aarcl011", OBJECT_SELF, 1);
break;
case 11:
o1 = CreateItemOnObject("nw_aarcl006", OBJECT_SELF, 1);
break;
case 12:
o1 = CreateItemOnObject("nw_aarcl007", OBJECT_SELF, 1);
break;
case 13:
o1 = CreateItemOnObject("nw_maarcl049", OBJECT_SELF, 1);
break;
case 14:
o1 = CreateItemOnObject("nw_ashlw001", OBJECT_SELF, 1);
break;
case 15:
o1 = CreateItemOnObject("nw_aarcl008", OBJECT_SELF, 1);
break;
}
DelayCommand(0.1, SetIdentified(o1, TRUE));
if (GetIsObjectValid(o2))
{
DelayCommand(0.1, SetIdentified(o2, TRUE));
}
}



















