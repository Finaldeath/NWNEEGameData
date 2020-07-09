//Include file for Kur-Tharsu functions

#include "x0_i0_enemy"
#include "x0_i0_position"

//Turn all creatures with a specific tag hostile
void TurnHostileByTag(string sTag, object oSource)
{
    int i = 1;
    object oCreature = GetNearestObjectByTag(sTag, oSource, i);

    while(oCreature != OBJECT_INVALID)
    {
        ChangeToStandardFaction(oCreature, STANDARD_FACTION_HOSTILE);
        i++;
        oCreature = GetNearestObjectByTag(sTag, oSource, i);
    }
}

//Determine if oCreature can be seen, making a Hide/Spot opposed roll if appropriate
int CanSeeCreature(object oCreature)
{
    if(GetHasEffect(EFFECT_TYPE_INVISIBILITY, oCreature) ||
       GetHasEffect(EFFECT_TYPE_IMPROVEDINVISIBILITY, oCreature)||
       GetHasEffect(EFFECT_TYPE_SANCTUARY, oCreature) ||
       GetHasEffect(EFFECT_TYPE_ETHEREAL, oCreature))
    {
        return FALSE;
    }

    //Make a spot check against any stealthed creature
    if(GetActionMode(oCreature, ACTION_MODE_STEALTH) == TRUE)
    {
        if((d20() + 15) >= (d20() + GetSkillRank(SKILL_HIDE, oCreature)))
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    return TRUE;
}

int IsTargetInRange(object oTarget, float fRange)
{
     float fDistance = GetDistanceToObject(oTarget);

     if(fDistance > -1.0 && fDistance <= fRange)
     {
         return TRUE;
     }
     return FALSE;
}

//Acquire a visible target
object AcquireTarget(float fRange)
{
    int i = 1;

    object oTarget = GetNearestEnemy(OBJECT_SELF, d3());

    //Try to obtain a random target
    if(oTarget != OBJECT_INVALID && IsTargetInRange(oTarget, fRange) &&
       CanSeeCreature(oTarget))
    {
        return oTarget;
    }

    //If a random target wasn't found, cycle through nearest enemies
    oTarget = GetNearestEnemy(OBJECT_SELF, i);

    while(oTarget != OBJECT_INVALID)
    {
        if(IsTargetInRange(oTarget, fRange))
        {
            if(CanSeeCreature(oTarget))
            {
                break;
            }
        }
        //Don't try to acquire target if nearest enemy is out of range
        else
        {
            oTarget = OBJECT_INVALID;
            break;
        }
        i++;
        oTarget = GetNearestEnemy(OBJECT_SELF, i);
    }

    return oTarget;
}

//Generate a random location close to the intended target
location GetRandomMissLocation(object oTarget)
{
    int nRand = d4();

    location loc;

    if(nRand == 1)
    {
        loc = GetFlankingLeftLocation(oTarget);
    }
    else
    if(nRand == 2)
    {
        loc = GetFlankingRightLocation(oTarget);
    }
    else
    if(nRand == 3)
    {
        loc = GetAheadLocation(oTarget);
    }
    else
    {
        loc = GetBehindLocation(oTarget);
    }

    return loc;
}

//Remove a named effect that was applied by a particular object
void RemoveNamedEffectByCreator(int nEffect, object oCreature, object oCreator)
{
    effect eEffect = GetFirstEffect(oCreature);

    while(GetIsEffectValid(eEffect))
    {
       if(GetEffectType(eEffect) == nEffect)
       {
           if(GetEffectCreator(eEffect) == oCreator)
           {
               RemoveEffect(oCreature, eEffect);
           }
       }
       eEffect = GetNextEffect(oCreature);
    }
}

//Apply and remove effects on Ogre Mage summoners
void ApplyOgreEffects(effect eEffect)
{
    object oOgre1 = GetLocalObject(OBJECT_SELF, "oOgre1");
    object oOgre2 = GetLocalObject(OBJECT_SELF, "oOgre2");
    object oOgre3 = GetLocalObject(OBJECT_SELF, "oOgre3");
    object oOgre4 = GetLocalObject(OBJECT_SELF, "oOgre4");

    effect e = GetFirstEffect(oOgre1);

    RemoveNamedEffectByCreator(EFFECT_TYPE_VISUALEFFECT, oOgre1, OBJECT_SELF);
    RemoveNamedEffectByCreator(EFFECT_TYPE_VISUALEFFECT, oOgre2, OBJECT_SELF);
    RemoveNamedEffectByCreator(EFFECT_TYPE_VISUALEFFECT, oOgre3, OBJECT_SELF);
    RemoveNamedEffectByCreator(EFFECT_TYPE_VISUALEFFECT, oOgre4, OBJECT_SELF);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oOgre1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oOgre2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oOgre3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oOgre4);
}

//Signal an event to any Shadovarian Assassins present on the upper floor
void SignalAssassinEvent(int nEvent)
{
    int i = 1;

    object oAssassin;
    object oPC = GetFirstPC();

    oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, i);

    while(oAssassin != OBJECT_INVALID)
    {
        SignalEvent(oAssassin, EventUserDefined(nEvent));
        oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, ++i);
    }
}

//Set Home location for Shadovar Assassin
void SetAssassinHomeLocation()
{
    int i = 1;

    object oAssassin;
    object oPC = GetFirstPC();

    oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, i);
    while(oAssassin != OBJECT_INVALID)
    {
        SetLocalString(oAssassin, "sHome",
                       "WP_THKTUF_JUMP_KT_ASSASSIN" + IntToString(i));
        oAssassin = GetNearestObjectByTag("ShadovarAssassinKT", oPC, ++i);
    }
}
