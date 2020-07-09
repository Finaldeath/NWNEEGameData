//::///////////////////////////////////////////////
//:: Warehouse OnEnter script
//:: aoe_warehouse.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Warehouse OnEnter script.

    Makes sure hostility settings between
    entering player and Redtip are correct.

    Starts cutscene for first time a player enters.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 10, 2005
//:://////////////////////////////////////////////
//:: Modified By: Keith Hayward
//:: Modified On: April 7, 2005
//:://////////////////////////////////////////////
#include "inc_balance"
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();
    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip);

    cs_AreaOnEnter_Poly(oPC);

    if(GetIsPCNotDM(oPC))
    {
        int nOnce = GetLocalInt(OBJECT_SELF, "aen_warehouse");
        // first time PC enters, start cutscene
        if(!nOnce)
        {
            // added a global variable to check the enter state.
            SetLocalInt(GetModule(), "aen_warehouse", TRUE);
            SetLocalInt(OBJECT_SELF, "aen_warehouse", TRUE);
            SetLocalInt(oRedtip, l_n_REDTIP_CUTSCENE_STARTED, TRUE);

    `       LevelUpNPC(oRedtip);

            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            cs_StartCutscene_Poly("cut_a2_wareh", "cut_a2_wareh_end", 1.5, TRUE);
        }
    }
}

