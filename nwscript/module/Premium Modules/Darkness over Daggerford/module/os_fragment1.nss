//::///////////////////////////////////////////////
//:: Name x2_def_spawn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spawn script


    2003-07-28: Georg Zoeller:

    If you set a ninteger on the creature named
    "X2_USERDEFINED_ONSPAWN_EVENTS"
    The creature will fire a pre and a post-spawn
    event on itself, depending on the value of that
    variable
    1 - Fire Userdefined Event 1510 (pre spawn)
    2 - Fire Userdefined Event 1511 (post spawn)
    3 - Fire both events

*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner, Georg Zoeller
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

//additional coding by Luspr
#include "x2_inc_switches"
void main()
{
    int nRandom;
    //apply new pulsing aura effect
    effect ePulse1  = EffectVisualEffect(VFX_DUR_AURA_PULSE_GREEN_WHITE);
    effect ePulse2  = EffectVisualEffect(VFX_DUR_AURA_PULSE_MAGENTA_RED);
    effect ePulse3  = EffectVisualEffect(VFX_DUR_AURA_PULSE_GREEN_BLACK);
    effect ePulse4  = EffectVisualEffect(VFX_DUR_AURA_PULSE_PURPLE_WHITE);
    nRandom = Random(4);
    if(nRandom ==1)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePulse1, OBJECT_SELF);
    }
    else if(nRandom ==2)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePulse2, OBJECT_SELF);
    }
    else if(nRandom ==3)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePulse3, OBJECT_SELF);
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePulse4, OBJECT_SELF);
    }
    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");

    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    /*  Fix for the new golems to reduce their number of attacks */

    int nNumber = GetLocalInt(OBJECT_SELF,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber >0 )
    {
        SetBaseAttackBonus(nNumber);
    }

    // Execute default OnSpawn script.
    ExecuteScript("nw_c2_default9", OBJECT_SELF);


    //Post Spawn event requeste
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }

}
