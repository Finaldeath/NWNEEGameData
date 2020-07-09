//::///////////////////////////////////////////////
//:: dla_i0_horseai
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Include file of DLA Horse system.
   Includes functions that deal with horse creature behaviour
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 17 Jan 2006
//:://////////////////////////////////////////////

#include "x0_i0_anims"
#include "dla_i0_const"
#include "x0_inc_henai"

//Gale 17 Jan 2006:
//Based on Bioware's AnimActionPlayRandomCloseRange
// Perform a random close-range action.
// This will include:
// - any of the immobile actions
// - randomly walking to a point near
// - going back to starting point
void DLA_AnimationCloseRange();

//Gale 17 Jan 2006:
//Based on Bioware's PlayMobileAmbientAnimations_NonAvian
//Checks if creature is busy with something, if not, then call DLA_AnimationCloseRange
void DLA_PlayCloseRangeAnimations();

//Gale 17 Jan 2006:
//Tie / Untie oHorse
//oHorse = Creature to be Tied / Untied
//bTied  = Boolean representing if the creature should be tied or untied
void DLA_SetIsTied(object oHorse=OBJECT_SELF, int bTied=TRUE);

//Gale 17 Jan 2006:
//Returns TRUE if oHorse is tied, and FALSE otherwise
int  DLA_GetIsTied(object oHorse=OBJECT_SELF){return GetLocalInt(oHorse, "DLA_HORSE_IS_TIED");}

//Gale 17 Jan 2006:
//Sets All associates of oPC to stand on their ground
void DLA_SetAssociateStandGround(object oPC);

//Syrsnein 25 June 2006:
//Moved this from dla_i0_joust
// Revert Standing Ground flag from PC associates
void DLA_SetAssociatesFollow(object oPC);

// Recursive function jumps all of oPCs henchmen (and their henchmen) to oWaypoint
//Syrsnein 14 July 2006
void DLA_JumpAssociatesToWaypoint(object oPC, object oWaypoint);

void DLA_SetAssociateStandGround(object oPC)
{
   object oCreature = GetFirstFactionMember(oPC, FALSE);
   do
   {
      if (GetMaster(oCreature) == oPC)
      {
          SetLocalInt(oCreature, "DLA_joust_stdgrnd", GetAssociateState(NW_ASC_MODE_STAND_GROUND, oCreature));
          SetAssociateState(NW_ASC_MODE_STAND_GROUND, TRUE, oCreature);
          AssignCommand(oCreature, ClearAllActions());
      }
   }
   while (GetIsObjectValid(oCreature = GetNextFactionMember(oPC, FALSE)));
}

void DLA_SetHorseNPCOwner(object oHorse, object oNPC)
{
  SetLocalString(oHorse, DLA_TAG_HORSE_NPC_OWNER, GetTag(oNPC));
}

void DLA_SetIsTied(object oHorse=OBJECT_SELF, int bTied=TRUE)
{
    if (bTied)
    {
        effect eImob = EffectCutsceneImmobilize();
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImob, oHorse);
        SetLocalInt(oHorse, "DLA_HORSE_IS_TIED", TRUE);
        SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHorse);
        SetAILevel(oHorse,AI_LEVEL_DEFAULT);
    }
    else
    {
        effect eLookFor = GetFirstEffect(oHorse);
        do
           if (GetEffectType(eLookFor) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
              {
                 RemoveEffect(oHorse, eLookFor);
                 break;
              }
        while (GetIsEffectValid(eLookFor = GetNextEffect(oHorse)));
        DeleteLocalInt(oHorse, "DLA_HORSE_IS_TIED");
    }
}

void DLA_PlayCloseRangeAnimations()
{
    if (!GetAnimationCondition(NW_ANIM_FLAG_INITIALIZED)) {
        // General initialization
        AnimInitialization();

        // also save our starting location
        SetLocalLocation(OBJECT_SELF,
                         "ANIM_START_LOCATION",
                         GetLocation(OBJECT_SELF));
    }

    // Short-circuit everything if we're not active yet
    if (!GetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE))
        return;

    // Check if we should turn off
    if (!CheckIsAnimActive(OBJECT_SELF))
        return;

    // Check current actions so we don't interrupt something in progress
    if (CheckCurrentAction()) {
        return;
    }

    // First check: go back to starting position and rest if we are hurt
    if (AnimActionRest()) {
        //AnimDebug("resting");
        return;
    }

    // Check if current modes should change
    CheckCurrentModes();

        DLA_AnimationCloseRange();
}

// Perform a random close-range action.
// This will include:
// - any of the immobile actions
// - randomly walking to a point near
// - going back to starting point
void DLA_AnimationCloseRange()
{
    // Clean out the action queue
    ClearAllActions();

    // For the rest of these, we check for specific rolls,
    // to ensure that we don't do a lot of lookups on any one
    // given pass.

    int nRoll = Random(6);

    if (nRoll == 1)
        ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
    else if (nRoll == 2)
        ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED);
    else if (nRoll == 3)
        ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED);
    //we should not even check for the remaining options if we are tied
    else if (DLA_GetIsTied(OBJECT_SELF))
        return;
    else if (nRoll == 4)
    {

        // do a random walk and then come back
        // to our current location
        ClearAllActions();
        location locCurr = GetLocation(OBJECT_SELF);
        ActionRandomWalk();
        ActionMoveToLocation(locCurr);
    }

    else if (nRoll == 5 && !GetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE))
    {
        // Move back to starting point, saved at initialization
        ActionMoveToLocation(GetLocalLocation(OBJECT_SELF,
                                              "ANIM_START_LOCATION"));
    }
}

void DLA_SetAssociatesFollow(object oPC)
{
   object oCreature = GetFirstFactionMember(oPC, FALSE);
   do
        if (GetAssociateType(oCreature) != ASSOCIATE_TYPE_NONE && GetMaster(oCreature) == oPC)
          SetAssociateState(NW_ASC_MODE_STAND_GROUND, GetLocalInt(oCreature, "DLA_joust_stdgrnd"), oCreature);
   while (GetIsObjectValid(oCreature = GetNextFactionMember(oPC, FALSE)));
}

// Recursive function jumps all of oPCs henchmen (and their henchmen) to oWaypoint
void DLA_JumpAssociatesToWaypoint(object oPC, object oWaypoint)
{
    if (!GetIsObjectValid(oPC)) return;

    int i=0;
    object oHenchman;
    while(GetIsObjectValid(oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC, ++i)))
    {
        AssignCommand(oHenchman, ActionJumpToObject(oWaypoint));
        DLA_JumpAssociatesToWaypoint(oHenchman, oWaypoint);
    }
}
/*
void main(){}
