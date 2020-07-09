//Teleport the party to the Scarred Lands from Kur-Tharsu Strongold upper floor

#include "hf_in_npc"

void main()
{
     object oPC = GetPCSpeaker();

     effect eVFX = EffectVisualEffect(VFX_IMP_AC_BONUS);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
     DelayCommand(1.5, TeleportToWaypoint(oPC, "WP_SCL_TELE_DEST"));
}
