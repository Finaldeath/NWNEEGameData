//::///////////////////////////////////////////////
//:: dla_c2_csintroud
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    User defined event script for use on module introduction cutscene actors
*/
//:://////////////////////////////////////////////
//:: Create By  : Syrsnein
//:: Created On : March 18, 2006
//:://////////////////////////////////////////////

#include "dla_i0_csintro"

void main()
{
    object oRedLeader   = GetObjectByTag(CS_Red);
    object oBlueLeader  = GetObjectByTag(CS_Blue);

    switch (GetUserDefinedEventNumber())
    {
        case CS_INTRO_KILLCHICKEN:
        {// oHG5 event to kill a chicken
            object oHG5     = OBJECT_SELF;
            object oChicken = GetObjectByTag("CS_Chicken1");
            AssignCommand(oHG5, ClearAllActions());
            ChangeFaction(oHG5, oRedLeader);
            ChangeFaction(oChicken, oBlueLeader);
            AssignCommand(oHG5, ActionAttack(oChicken));
        }; break;
    }
}
