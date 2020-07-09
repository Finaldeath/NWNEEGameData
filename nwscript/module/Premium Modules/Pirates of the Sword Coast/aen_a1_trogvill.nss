//::///////////////////////////////////////////////
//:: aen_a1_trogvill
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    a Player has entered the Trog village.
    Level-up the trogs accordingly.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_balance"
#include "inc_global"

void main()
{
    object oModule = GetModule();
    object oEnter = GetEnteringObject();
    object oTrogPLC = GetObjectByTag("a1_trogneut");
    object oCursor = GetFirstFactionMember(oTrogPLC, FALSE);
    int iDoOnce = GetLocalInt(oModule, "aen_a1_trogvill");

    cs_AreaOnEnter_Poly(oEnter);

    // on enter the village for the first time levelup the Trogs
    if ((GetIsPC(oEnter) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "aen_a1_trogvill", TRUE);
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            if (GetObjectType(oCursor) == OBJECT_TYPE_CREATURE &&
                GetArea(oCursor)==OBJECT_SELF)
            {
                LevelUpNPC(OBJECT_SELF);
            }

            oCursor = GetNextFactionMember(oTrogPLC, FALSE);
        }
    }
}
