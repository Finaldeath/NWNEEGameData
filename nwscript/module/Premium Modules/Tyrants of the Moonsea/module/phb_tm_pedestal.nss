//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: phb_tm_pedestal
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Check to see if each of the pedestals has the
//       appropriate gemstone. If so, create a portal
//       to the second floor of the Dreadspire.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_2q4luskan"
void main()
{

object oPC = GetFirstPC();

if (GetLocalInt(OBJECT_SELF, "fired") == 1)

return;

object oGreen = GetObjectByTag("GreenPedestal");

if (GetItemPossessedBy(oGreen, "HugeEmerald")== OBJECT_INVALID)
   return;

object oBlue = GetObjectByTag("BluePedestal");

if (GetItemPossessedBy(oBlue, "HugeSapphire")== OBJECT_INVALID)
   return;

object oOrange = GetObjectByTag("OrangePedestal");

if (GetItemPossessedBy(oOrange, "HugeTopaz")== OBJECT_INVALID)
   return;

object oRed = GetObjectByTag("RedPedestal");

if (GetItemPossessedBy(oRed, "HugeRuby")== OBJECT_INVALID)
   return;

object oTarget;
oTarget = GetObjectByTag("WP_Dreadspire_Portal1");

int nInt;
nInt = GetObjectType(oTarget);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_IMPLOSION), GetLocation(oTarget));

location lTarget;
oTarget = GetWaypointByTag("WP_Dreadspire_Portal1");

lTarget = GetLocation(oTarget);

DelayCommand(1.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "portaltosecondfl", lTarget));

DelayCommand(4.0, GiveXPToCreature(oPC, 125));

DelayCommand(4.0, PlaySound("as_cv_eulpipe1"));

SetLocalInt(OBJECT_SELF, "fired", 1);

}

