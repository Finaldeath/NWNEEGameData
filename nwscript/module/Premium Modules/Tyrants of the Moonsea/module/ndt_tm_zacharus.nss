//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ndt_tm_zacharus
// DATE: September 14, 2005
// AUTH: Luke Scull
// NOTE: Unsummons green slaad on death, also includes
//       safety function to teleport PC to correct spot
//       for Sharalyn conversation just in case player
//       lures Zacharus outside temple during battle.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

// Set int on player

SetLocalInt(GetFirstPC(), "zacharusdead", 1);

// Define slaad

object oSlaad1 = GetObjectByTag("TempleGreenSlaad1");
object oSlaad2 = GetObjectByTag("TempleGreenSlaad2");

// Apply unsummon VFX and then destroy them

ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oSlaad1);
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oSlaad2);

DestroyObject(oSlaad1, 3.0);

DestroyObject(oSlaad2, 3.0);

// Define PC and area

object oPC = GetFirstPC();

object oArea = GetObjectByTag("VoonlarTempleofBane");

// If the player isn't currently in the Temple of Bane then they are
// automatically teleported to correct trigger for continuity purposes

if ((GetArea(oPC)== oArea))
   return;

object oTarget;
oTarget = GetWaypointByTag("WP_Sharalyn_Meeting");

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToObject(oTarget));


}

