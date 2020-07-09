// dla_atbarrexplod
// B W-Husey
//The barrel of oil explodes after a few seconds. If the PC put the barrel in a burn area, then things burn.

#include "cu_functions"

void main()
{
        float fDelay = IntToFloat(3+d6());
        object oPC = GetPCSpeaker();
        // This section deals with the Piracy quest if the PC just blew the ship up.
        if (GetLocalInt(OBJECT_SELF,"nShip")==1)
        {
        AddJournalQuestEntry("Piracy",45,oPC);
        AllParty("nPiracy",oPC,4);
        }
        //end section

        DelayCommand(fDelay,ActionCastSpellAtObject(SPELL_FIREBALL,OBJECT_SELF,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
        if (GetTag(OBJECT_SELF) =="OilBarrel2")
        {
        DelayCommand(fDelay+=0.1,ActionCreatePlace("plc_flamesmall",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,5))));
        DelayCommand(fDelay+=0.1,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,4))));
        DelayCommand(fDelay+=0.1,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,3))));
        DelayCommand(fDelay+=0.1,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,2))));
        DelayCommand(fDelay+=0.1,ActionCreatePlace("plc_flamelarge",GetLocation(GetNearestObjectByTag("WP_Flame",OBJECT_SELF,1))));
        }
        DelayCommand(fDelay+=0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(30),OBJECT_SELF));
}
