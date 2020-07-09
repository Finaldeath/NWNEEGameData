//::///////////////////////////////////////////////
//:: dla_o2_deathbeam
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    OnUserDefined script for triggers and placables associated with the
    obstacles in Wyvernwater Castle: Through the Portal
*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: 5 April, 2006
//:://////////////////////////////////////////////
#include "x0_i0_petrify"
#include "dla_i0_const"
#include "dla_i0_debug"

const int DEATHBEAM_DEBUG = TRUE;

void DeathBeamDebug(string sMessage, int bForce=FALSE)
{
     if (!DEATHBEAM_DEBUG && !bForce) return;
     DLA_Debug("[DLA DEATHBEAM DEBUG] " + sMessage);
}

// Activate/deactivate a placeable piece based on bActivate
void DeathbeamActivate(object oPart, int bActivate=TRUE)
{
    DeathBeamDebug("<DeathbeamActivate>");
    AssignCommand(oPart, ClearAllActions());
    if (bActivate && !GetLocalInt(oPart, "bAnimOn"))
    {
        DeathBeamDebug("   Playing activation animation for " + GetTag(oPart));
        SetLocalInt(oPart, "bAnimOn", TRUE);
        AssignCommand(oPart, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    }
    else if (!bActivate && GetLocalInt(oPart, "bAnimOn"))
    {
        DeathBeamDebug("   Playing de-activation animation for " + GetTag(oPart));
        SetLocalInt(oPart, "bAnimOn", FALSE);
        AssignCommand(oPart, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
}

// Activate a deathbeam group
void DeathbeamActivateGroup(object oTrigger, int bActivate=TRUE)
{
    DeathBeamDebug("<DeathbeamActivateGroup>");
    string sI   = GetStringRight(GetTag(oTrigger), 1);
    string sPre = GetStringLeft (GetTag(oTrigger), 3);
    object oBarrier = GetObjectByTag(sPre + "Barrier" + sI);
    object oSparks  = GetObjectByTag(sPre + "Sparks"  + sI);
    object oLightL  = GetObjectByTag(sPre + "LightL"  + sI);
    object oLightC  = GetObjectByTag(sPre + "Light"   + sI);
    object oLightR  = GetObjectByTag(sPre + "LightR"  + sI);
    object oPillarL = GetObjectByTag(sPre + "PillarL" + sI);
    object oPillarR = GetObjectByTag(sPre + "PillarR" + sI);

    DeathbeamActivate(oBarrier,  bActivate);
    DeathbeamActivate(oSparks ,  bActivate);
    DeathbeamActivate(oLightL ,  bActivate);
    DeathbeamActivate(oLightR ,  bActivate);
    DeathbeamActivate(oLightC , !bActivate);
    DeathbeamActivate(oPillarL,  bActivate);
    DeathbeamActivate(oPillarR,  bActivate);

    if (bActivate)
    {
        DeathBeamDebug("Activating group for " + GetTag(oTrigger));
        SetLocalInt(oTrigger, "nBeamOn", TRUE);
    }
    else
    {
        DeathBeamDebug("De-activating group for " + GetTag(oTrigger));
        SetLocalInt(oTrigger, "nBeamOn", FALSE);
    }
}

void main()
{
    DeathBeamDebug("[dla_o2_deathbeam]");
    int nEventType = GetUserDefinedEventNumber();
    string sI   = GetStringRight(GetTag(OBJECT_SELF), 1);
    string sPre = GetStringLeft (GetTag(OBJECT_SELF), 3);

    object oTrigger = GetObjectByTag(sPre + "Trigger" + sI);

    switch (nEventType)
    {
        case DLA_EVENT_DEATHBEAM_ON:
        {
            DeathBeamDebug("   Deathbeam Event On for " + GetTag(oTrigger));
            int nTimer = GetLocalInt(oTrigger, "nTimer");
            if (GetLocalInt(oTrigger, "nTimer") > 0)
            {
                DeathBeamDebug("   Deathbeam timer found on " + GetTag(oTrigger) + " for " + IntToString(nTimer) + " seconds.");
                DelayCommand(1.0, SignalEvent(oTrigger, EventUserDefined(DLA_EVENT_DEATHBEAM_ON)));
                nTimer--;
                SetLocalInt(oTrigger, "nTimer", nTimer);
            }
            else
            {
                DeathBeamDebug("   Activating Deathbeam for " + GetTag(oTrigger));
                DeathbeamActivateGroup(oTrigger, TRUE);
            }
            break;
        }

        case DLA_EVENT_DEATHBEAM_OFF:
        {
            DeathBeamDebug("   Deathbeam Event Off for " + GetTag(oTrigger));
            DeathbeamActivateGroup(oTrigger, FALSE);
            break;
        }

        case DLA_EVENT_DEATHBEAM_TRIGGER:
        {
            if (GetLocalInt(oTrigger, "nBeamOn"))
            {
                object oEnter = GetEnteringObject();
                effect eDmg = EffectDamage(500, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oEnter);
                DeathBeamDebug("Triggered deathbeam damage for " + GetTag(oTrigger));
            }
            break;
        }
    }
}
