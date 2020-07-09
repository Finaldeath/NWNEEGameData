//::///////////////////////////////////////////////
//:: inc_polymorphfix.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file containing a fix for a polymorph
    issue.

    This is a very elaborate HACK.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: May 4, 2005
//:://////////////////////////////////////////////
#include "inc_global"

void Transition_RemovePolymorphIfNecessary(object oPC, object oTarget);

void RemovePolymorph(object oPC);

void Transition_RemovePolymorphIfNecessary(object oPC, object oTarget)
{
    // ignore DM's - not sure if this is really needed, but better
    // safe than sorry.
    if(GetIsDM(oPC)) return;

    object oTargetArea = GetArea(oTarget);
    object oCurrentArea = GetArea(OBJECT_SELF);
    string sTagTarget = GetTag(oTargetArea);
    string sTagCurrent = GetTag(oCurrentArea);

    // Target = Neverwinter Docks
    if(sTagTarget=="Map_M1Q4A")
    {
        // Only one cutscene starts in the OnEnter in the docks, and it
        // should be impossible to be in a polymorphed state at that point.
        // So, this is only necessary if that bandit cutscene is currently
        // playing.
        if(cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Golden Apple Upstairs
    if(sTagTarget=="MAP_M1Q4Q")
    {
        // A cutscene fires in the first PC OnEnter. Remove polymorph
        // in that instance, and for any other PC's if that cutscene is
        // still running.
        if( !cs_GetCutsceneStarted(1, oTargetArea) ||
            cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Tropical Island: North Shore
    if(sTagTarget=="a1_jungle")
    {
        // No cutscene with first OnEnter, but there is one that plays
        // so remove polymorph if that cutscene is running.
        if(cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Tropical Island: South Shore
    if(sTagTarget=="a1_beach")
    {
        // There is a cutscene on first OnEnter, but it's not through an
        // area transition. Here we just need to remove polymorph if there
        // is a cutscene currently running... and we may not even need
        // that, I'm not 100%, but it won't hurt anything by being here.
        if(cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Spindrift: Vantabular's Lighthouse
    if(sTagTarget=="TheLighthouse")
    {
        // No cutscene with first OnEnter, but there is one that plays
        // so remove polymorph if that cutscene is running.
        if(cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Spindrift: Warehouse
    if(sTagTarget=="TownWarehouse")
    {
        // A cutscene runs on first enter - if it hasn't run, remove polymorph.
        // Also remove polymorph if a cutscene is currently running.
        if(cs_GetCutsceneRunning(oTargetArea) ||
           !cs_GetCutsceneStarted(1, oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Spindrift: Governor Blackeye's Manor
    if(sTagTarget=="SpindriftMayorsOffice")
    {
        // Condition 1: if a cutscene is currently running in next area, remove
        // polymorph. That's simple. Condition 2: If the variable specified is
        // set, it means that a cutscene should start when a PC enters the area.
        // I do a sanity check on whether that cutscene has ever ran before.
        // If it hasn't, and the variable is set, we remove polymorph.
        if(cs_GetCutsceneRunning(oTargetArea) ||
             ( GetLocalInt(OBJECT_SELF, l_n_XPM_START_CS_ON_AEN) &&
               !cs_GetCutsceneStarted(1, oTargetArea) ))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Spindrift: Willigan's Manor
    if(sTagTarget=="SpindriftWilligansManor")
    {
        // A cutscene can start via OnEnter, but not when using an area
        // transition. So only remove polymorph if a cutscene is currently
        // running.
        if(cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = Temple of Umberlee: Sea Caves
    if(sTagTarget=="BeneathTempleTEMPAREA")
    {
        // No cutscene with first OnEnter, but there is one that plays
        // so remove polymorph if that cutscene is running.
        if(cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = The Midnight Rose: Belowdeck (Act 0 "at sea" version)
    if(sTagTarget=="BelowDeck_MidnightRose_AtSea")
    {
        // No cutscene with first OnEnter, but there is one that plays
        // so remove polymorph if that cutscene is running.
        if(cs_GetCutsceneRunning(oTargetArea))
        {
            RemovePolymorph(oPC);
        }
    }

    // Target = The Stench Overwhelms You...
    if(sTagTarget=="a1_trogstrhold2")
    {
        // always remove polymorph here
        RemovePolymorph(oPC);
    }
}

void RemovePolymorph(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while(GetIsEffectValid(e))
    {
        if(GetEffectType(e)==EFFECT_TYPE_POLYMORPH)
        {
            DelayCommand(0.01, RemoveEffect(oPC, e));
        }
        e = GetNextEffect(oPC);
    }
}
