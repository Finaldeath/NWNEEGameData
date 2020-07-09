//::///////////////////////////////////////////////
//:: dla_wyv_ondamage
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
     OnDamaged script for wyvern.
     When reach half hitpoints, it flies away
     Used on juveniles
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 5 Feb 2006
//:: Modified by B W-Husey, 25th March
//:://////////////////////////////////////////////
#include "cu_functions"
void main()
{
    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }
    //hurt, not back at the nest and can move
    if (GetCurrentHitPoints() <= GetMaxHitPoints()/2  && GetLocalInt(OBJECT_SELF,"nWontRun")<1 && GetIsMobile(OBJECT_SELF))
    {
        //Declare variables
        effect eDisap;
        location lLoc = GetLocation(GetWaypointByTag("TP_Wyverns"));
        effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
        //stop wyvern from being damaged/diverted
       DelayCommand(2.0,SetPlotFlag(OBJECT_SELF, TRUE));
       SetIsTemporaryNeutral(GetLastDamager(),OBJECT_SELF,TRUE,30.0);
       ClearAllActions();
       //Wyvern does this only once
       SetLocalInt(OBJECT_SELF,"nWontRun",1);
       //Now do the visuals
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
       if (GetTag(GetArea(OBJECT_SELF))=="CastleWyvernwater")     //I have somewhere to go to
        {
            eDisap = EffectDisappearAppear(lLoc);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDisap, OBJECT_SELF,10.0);
            DelayCommand(9.0,SetPlotFlag(OBJECT_SELF,FALSE));
        }

       else     //I don't have somewhere to go to
        {
            eDisap = EffectDisappear();
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisap, OBJECT_SELF);
        }
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
