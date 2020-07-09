//::///////////////////////////////////////////////
//:: ten_elementalcut
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This trigger on enter script will start the
    act1 elemental avatar cut scene.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    object oCursor;

    effect eFear = EffectFrightened();
    location lSafty = GetLocation(GetWaypointByTag("a1_junglefear"));
    int iFear = GetLocalInt(oPC, "iFEARFIRE");

    if (GetIsPCNotDM(oPC) == TRUE)
    {
        oCursor = GetFirstObjectInArea(oArea);
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            //hammer fix to prevent hostiles from inerfereing in cutscene.
            if ((GetObjectType(oCursor) == OBJECT_TYPE_CREATURE)
              && (GetIsEnemy(oCursor, oPC) == TRUE)
              && (GetIsPC(oCursor) == FALSE))
            {
                AssignCommand(oCursor, ClearAllActions(TRUE));
                DestroyObject(oCursor, 0.2f);
            }

            oCursor = GetNextObjectInArea(oArea);
        }

        cs_StartCutscene_Poly("cut_fireelement", "", 0.0f, FALSE, FALSE, 10, oArea);
        DestroyObject(OBJECT_SELF, 1.0f);
    }
    else if (!GetIsDM(oPC))
    {
        if (iFear != FALSE)
        {
            AssignCommand(oPC, JumpToLocation(lSafty));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oPC, 10.0f);
        }
    }
}
