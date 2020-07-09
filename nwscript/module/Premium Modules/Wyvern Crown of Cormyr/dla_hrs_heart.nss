//:://////////////////////////////////////////////////
//:: dla_hrs_heart
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

  OnHeartbeat event handler for horses.
  Rewriten AI code to give horse specific behaviour

-------------------Notes on Horse AI files------------------

    These are the files that are referenced in each AI event if this is NOT a
    DLA horse henchman:
nw_c2_defaulte     = OnBlocked
nw_c2_default3     = OnCombatRoundEnd
nw_c2_default4     = OnConversation
x2_def_ondamage    = OnDamaged
nw_c2_default7     = OnDeath
nw_c2_default8     = OnDisturbed
nw_c2_default1     = OnHeartBeat
nw_c2_default2     = OnPerception
x2_def_attacked    = OnPhysicalAttacked
nw_c2_defaulta     = OnRest
x2_def_spawn       = OnSpawn
x2_def_spellcast   = OnSpellCastAt
x2_def_userdef     = OnUserDefined

*/

//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Dec 10, 2005
//:://////////////////////////////////////////////
// Modified 6/16/2006 - Deva Winblood - add non-warhorse fear(mantis #1471)
// Modified 8/02/2006 - Deva Winblood - Deal with LacHorse follow (mantis #1997)
// Modified 8/04/2006 - Deva Winblood - LacHorse will vanish if mounted on another
// Modified 10/11/2006- Deva Winblood - Patch 1 - Modified so Paladin Mount would not despawn in jousting grounds

#include "X0_INC_HENAI"
#include "dla_i0_horse"
#include "dla_i0_horseai"
#include "dla_i0_time"


void privateDLA_ProcessLacHorse(object oHorse)
{ // PURPOSE: Prevent infinite following of LacHorse if it is currently mounted

    object oMyMaster=GetLocalObject(oHorse,"oDLAMyMaster");
    object oWP=GetWaypointByTag(DLA_UNMOUNTED_MOUNT_MOVE);

    if (GetIsObjectValid(oMyMaster)&&DLA_GetIsMounted(oMyMaster)&&GetLocalObject(oMyMaster,"oDLAMyMount")==oHorse)
    { // should not be following

        if (GetArea(oHorse)!=GetArea(oWP))
        { // bad area
            SetCommandable(TRUE,oHorse);
            SetAILevel(oHorse,AI_LEVEL_NORMAL);
            SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHorse);
            AssignCommand(oHorse,ClearAllActions(TRUE));
            AssignCommand(oHorse,JumpToObject(oWP));
            DelayCommand(1.0,privateDLA_ProcessLacHorse(oHorse));
        } // bad area
        else
        { // stored
            SetAILevel(oHorse,AI_LEVEL_VERY_LOW);
            AssignCommand(oHorse,ClearAllActions(TRUE));
            SetCommandable(FALSE,oHorse);
        } // stored

    } // should not be following

} // privateDLA_ProcessLacHorse()



void main()
{
    effect eVis;
    int bDying;
    int nStealth;
    int nN;
    object oOb;
    object oSelf=OBJECT_SELF;

    if (GetTag(oSelf)=="LacHorse") privateDLA_ProcessLacHorse(oSelf);

    if (GetLocalInt(oSelf,"bDLAMountDespawn")) DestroyObject(oSelf);

    //if is just a wandering horse, not owned by anyone
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN)
    {


          if(GetHasEffect(EFFECT_TYPE_SLEEP))
          {
               // If we're asleep and this is the result of sleeping
               // at night, apply the floating 'z's visual effect
               // every so often

               eVis = EffectVisualEffect(VFX_IMP_SLEEP);
               if(d10() > 6)
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
          }
          // Check to see if we should be playing default animations
          // - make sure we don't have any current targets
          else if ( !GetIsObjectValid(GetAttemptedAttackTarget())
               && !GetIsObjectValid(GetAttemptedSpellTarget())
               && !GetIsObjectValid(GetNearestSeenEnemy()))
                   if (!IsInConversation(OBJECT_SELF))
                   { // updated for random sounds
/*
                       if (d100()<11)
                       { // 10% per heartbeat
                           if (d100()<91)
                           { // 90% snort
                               PlaySound("c_horse_slct");
                           } // 90% snort
                           else
                           { // 10% whinny
                               PlaySound("c_horse_bat1");
                           } // 10% whinny
                       } // 10% per heartbeat
*/
                       DLA_PlayCloseRangeAnimations();
                   } // updated for random sounds
        // Send the user-defined event signal if specified
          if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
              SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_HEARTBEAT));
          return;
    }

    // If the henchman is in dying mode, make sure
    // they are non commandable. Sometimes they seem to
    // 'slip' out of this mode
    bDying = GetIsHenchmanDying();

    if(bDying == TRUE)
    {
        int bCommandable = GetCommandable();
        if(bCommandable == TRUE)
        {
            // lie down again
            ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 65.0);
            SetCommandable(FALSE);
        }
    }
    // If we're dying or busy, we return
    // (without sending the user-defined event)
    if(GetAssociateState(NW_ASC_IS_BUSY) || bDying)
    {
        return;
    }

    // Check to see if should re-enter stealth mode
    if(GetIsInCombat() == FALSE)
    {
        nStealth = GetLocalInt(OBJECT_SELF, "X2_HENCH_STEALTH_MODE");
        if((nStealth == 1 || nStealth == 2)
            && GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == FALSE)
        {
            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
        }

        //Deva Winblood  May 15, 2006:
        //added support for paladin horse despawn, and avoid
        //non-master support.
      if (DLA_GetIsPaladinMount(OBJECT_SELF)&&!IsInConversation(OBJECT_SELF)&&!GetIsDMPossessed(OBJECT_SELF))
      { // paladin mount AI stuff

        eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
        oOb  = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,1);

        if (oOb!=GetMaster(oOb)&&(GetObjectSeen(oOb)||GetObjectHeard(oOb))&&!DLA_GetIsDLAHorse(oOb))
        { // if too close then move away
          if (GetDistanceBetween(OBJECT_SELF,oOb)<3.0)
          { // move away
            ActionMoveAwayFromObject(oOb,FALSE,4.0);
          } // move away
        } // if too close then move away

        nN=GetLocalInt(OBJECT_SELF,"nDespawnHour");  // Deva 10/11/2006 - fix for despawning in Jousting grounds
        if (nN<=DLA_GetAbsoluteHour()&&GetTag(GetArea(OBJECT_SELF))!="ThunderstoneTiltingGround")
        { // despawn
          //SendMessageToPC(GetFirstPC(),"Despawn Paladin Mount [Area:'"+GetTag(GetArea(OBJECT_SELF))+"']");
          ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(OBJECT_SELF));
          oOb=OBJECT_SELF;
          DLA_DespawnPaladinMount(oOb);
        } // despawn
      } // paladin mount AI Stuff
    }

    // Deva Winblood - 6/16/2006 - added by request of Ben
    oOb=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oSelf,1,CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
    if (GetIsObjectValid(oOb)&&!DLA_GetIsWarhorse(oSelf))
    { // move away from enemies
        if (GetDistanceBetween(oOb,oSelf)<15.0)
        { // move
            AssignCommand(oSelf,ClearAllActions(TRUE));
            AssignCommand(oSelf,ActionMoveAwayFromObject(oOb,TRUE));
        } // move
        else
        { // default
            ExecuteScript("nw_ch_ac1", OBJECT_SELF);
        } // default
    } // move away from enemies
    else
    { // default
        ExecuteScript("nw_ch_ac1", OBJECT_SELF);
    } // default
}



