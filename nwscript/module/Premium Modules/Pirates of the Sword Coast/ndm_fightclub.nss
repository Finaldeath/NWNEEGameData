//::///////////////////////////////////////////////
//:: ndm_fightclub
//:: Based on x2_def_ondamage
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnDamaged script for the fighters in
    Redtip's warehouse.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 14/05
//:://////////////////////////////////////////////
#include "inc_global"

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

    object oArea = GetArea(OBJECT_SELF);
    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip, oArea);
    // if the fightclub fight is active, and this guy is supposed to lose
    // then check for winning conditions
    if( (GetLocalInt(oRedtip, l_n_FIGHTCLUB_FIGHTACTIVE)) &&
        (GetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_PARTICIPANT) == l_nv_FIGHTCLUB_PARTICIPANT_LOSER) )
    {
        // winning condition - have taken more than 5 points of damage, or am
        // at 1hp (in case they were only given like 3hp or something)
        int nCurrentHP = GetCurrentHitPoints();
        int nMaxHP = GetMaxHitPoints();
        if(nCurrentHP < 2 || (nMaxHP-nCurrentHP) > 5)
        {
            // make loser fall down
            ClearAllActions(TRUE);
            PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 5.0);
            // find winner
            object oFighter1 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER1);
            object oFighter2 = GetLocalObject(oRedtip, l_o_FIGHTCLUB_FIGHTER2);
            object oWinner;
            if(OBJECT_SELF == oFighter1) oWinner = oFighter2;
            else oWinner = oFighter1;
            // make winner taunt
            AssignCommand(oWinner, ClearAllActions(TRUE));
            AssignCommand(oWinner, PlayAnimation(ANIMATION_FIREFORGET_TAUNT));

            cs_ResetDelay(-1.0, 0.0, oArea);
            cs_EndCutscene(3.0, FALSE, FALSE, FADE_SPEED_MEDIUM, -1, oArea);
        }
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
