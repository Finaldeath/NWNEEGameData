#include "x2_am_inc"

void main()
{
 // * turns self off by default
 //if (GetLocalInt(OBJECT_SELF, "NW_L_TURNSELFOFF") == 0)
 //{
 //
 //   PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
 //   DelayCommand(0.4,SetPlaceableIllumination(OBJECT_SELF, FALSE));
 //   SetLocalInt(OBJECT_SELF,"NW_L_AMION",0);
 //   DelayCommand(0.6,RecomputeStaticLighting(GetArea(OBJECT_SELF)));
 //
 //    SetLocalInt(OBJECT_SELF, "NW_L_TURNSELFOFF", 10);
 //}

 // * turn lamp on
 if (GetLocalInt(OBJECT_SELF,"NW_L_AMION") == 0 )
 {
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(0.4,SetPlaceableIllumination(OBJECT_SELF, TRUE));
    SetLocalInt(OBJECT_SELF,"NW_L_AMION",1);
    DelayCommand(0.6,RecomputeStaticLighting(GetArea(OBJECT_SELF)));


 }
}
