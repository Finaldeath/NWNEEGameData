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

    2007-12-31: Deva Winblood
    Modified to look for X3_HORSE_OWNER_TAG and if
    it is defined look for an NPC with that tag
    nearby or in the module (checks near first).
    It will make that NPC this horse's master.

*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner, Georg Zoeller
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "x2_inc_switches"
void main()
{
    string sTag;
    object oNPC;
    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");


    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
     SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    //Position shark on deck, on its side and wounded
    int nDamage = GetCurrentHitPoints() - 1;

    effect eDamage = EffectDamage(nDamage);
    effect eParalyze = SupernaturalEffect(EffectParalyze());
    effect eFreeze = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect eLink = EffectLinkEffects(eParalyze, eFreeze);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF);

    float xRotate =  GetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_ROTATE_X);
    float zRotate =  GetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_ROTATE_Z);
    float zTranslate =  GetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z);

    xRotate += 90;
    zRotate += 270;
    zTranslate += 0.1;

    SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_ROTATE_X, xRotate);
    SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_ROTATE_Z, zRotate);
    SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, zTranslate);

    // Execute default OnSpawn script.
    ExecuteScript("nw_c2_default9", OBJECT_SELF);


    //Post Spawn event requeste
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }
}
