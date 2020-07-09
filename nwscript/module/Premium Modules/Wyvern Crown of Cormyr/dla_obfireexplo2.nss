
// B W-Husey
// Explosion for an oil barrel - this is the version when it was placed in a 'burn' area.

#include "cu_functions"

void main()
{
        if (GetDamageDealtByType(DAMAGE_TYPE_FIRE)>0)
        {
        DelayCommand(2.9,ActionCreatePlace("plc_flamesmall",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,5))));
        DelayCommand(2.9,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,4))));
        DelayCommand(2.9,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,3))));
        DelayCommand(2.9,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,2))));
        DelayCommand(2.9,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,1))));
        DelayCommand(3.0,ActionCastSpellAtObject(SPELL_FIREBALL,OBJECT_SELF,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
        DelayCommand(3.2,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(30),OBJECT_SELF));
        }
}
