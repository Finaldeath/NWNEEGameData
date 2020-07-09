////////////////////////////////////////////////////////////////////////////////
// dla_areaentmelee - Area Enter script for General Melee to insure no horses
// arrive.
// Scripted by Deva B. Winblood    7/14/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"
#include "x0_inc_henai"



void privateMoveHorse(object oHorse,object oWP)
{ // PURPOSE: Make sure horse arrives where it should and then hitch it
    if (GetArea(oWP)!=GetArea(oHorse)||GetDistanceBetween(oWP,oHorse)>5.0)
    { // jump the horse
        AssignCommand(oHorse,ClearAllActions(TRUE));
        AssignCommand(oHorse,JumpToObject(oWP));
        DelayCommand(0.5,privateMoveHorse(oHorse,oWP));
    } // jump the horse
    else
    { // arrived
        DLA_SetIsTied(oHorse,TRUE);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHorse);
        SetAILevel(oHorse,AI_LEVEL_DEFAULT);
    } // arrived
} // privateMoveHorse()




void main()
{
   object oWP=GetWaypointByTag("wp_melee_hitch");
   object oOb=GetEnteringObject();
   if (GetIsObjectValid(oOb)&&GetIsObjectValid(oWP))
   { // objects are valid
       if (DLA_GetIsDLAHorse(oOb))
       { // move horse out of this area
           privateMoveHorse(oOb,oWP);
       } // move horse out of this area
   } // objects are valid

}
