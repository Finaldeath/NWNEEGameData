//::///////////////////////////////////////////////
//:: dla_i0_faction
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Include file for faction related functions.
*/
//:://////////////////////////////////////////////
//:: Created By: Deva B. Winblood
//:: Created On: 5/7/2006
//:://////////////////////////////////////////////

#include "nw_i0_generic"

/////////////////////
// PROTOTYPES
/////////////////////

// Deva B. Winblood 5/7/2006:
// Make any nearby commoner, defenders, merchants non-hostile to oPC
void DLA_AdjustFactions(object oPC);

// Deva B. Winblood 6/15/2006:
// Make all associates of oPC not hostile to oTarget and vice versa
void DLA_AdjustFactionAssociates(object oPC,object oTarget);

/////////////////////
// FUNCTIONS
/////////////////////

void DLA_AdjustFactions(object oPC)
{

  int nN=1;
  object oEnemy    = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,nN);
  object oCommoner = GetObjectByTag("cr_comfact"); // commoner faction representative
  object oDefender = GetObjectByTag("cr_deffact"); // defender faction representative
  object oMerchant = GetObjectByTag("cr_merfact"); // merchant faction representative

  while(GetIsObjectValid(oEnemy))
  { // check all nearby enemies

      if (GetIsFriend(oCommoner,oEnemy))
      { // commoner
          DelayCommand(0.1,SetIsTemporaryNeutral(oPC,oEnemy));
          DelayCommand(0.1,SetIsTemporaryNeutral(oEnemy,oPC));
          DelayCommand(0.11,DLA_AdjustFactionAssociates(oPC,oEnemy));
          if (GetIsInCombat(oEnemy))
              DelayCommand(0.2,AssignCommand(oEnemy,ClearAllActions(TRUE)));
          DelayCommand(0.1,AdjustReputation(oPC,oEnemy,50));
      } // commoner

      else if (GetIsFriend(oDefender,oEnemy))
      { // defender
          DelayCommand(0.1,SetIsTemporaryNeutral(oPC,oEnemy));
          DelayCommand(0.1,SetIsTemporaryNeutral(oEnemy,oPC));
          DelayCommand(0.11,DLA_AdjustFactionAssociates(oPC,oEnemy));
          if (GetIsInCombat(oEnemy))
              DelayCommand(0.2,AssignCommand(oEnemy,ClearAllActions(TRUE)));
          DelayCommand(0.1,AdjustReputation(oPC,oEnemy,50));
      } // defender

      else if (GetIsFriend(oMerchant,oEnemy))
      { // merchant
           DelayCommand(0.1,SetIsTemporaryNeutral(oPC,oEnemy));
           DelayCommand(0.1,SetIsTemporaryNeutral(oEnemy,oPC));
           DelayCommand(0.11,DLA_AdjustFactionAssociates(oPC,oEnemy));
           if (GetIsInCombat(oEnemy))
               DelayCommand(0.2,AssignCommand(oEnemy,ClearAllActions(TRUE)));
           DelayCommand(0.1,AdjustReputation(oPC,oEnemy,50));
       } // merchant

       nN++;
       oEnemy=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oPC,nN);
   } // check all nearby enemies
} // DLA_AdjustFactions()




void DLA_AdjustFactionAssociates(object oPC,object oTarget)
{ // PURPOSE: Update associates
    int nN=1;
    object oAssociate=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // henchmen
        SetIsTemporaryNeutral(oAssociate,oTarget);
        SetIsTemporaryNeutral(oTarget,oAssociate);
        if (GetLocalObject(oAssociate,"NW_GENERIC_LAST_ATTACK_TARGET")==oTarget)
        { // abort attack
            DetermineCombatRound();
        } // abort attack
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    } // henchmen
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // summoned
        SetIsTemporaryNeutral(oAssociate,oTarget);
        SetIsTemporaryNeutral(oTarget,oAssociate);
        if (GetLocalObject(oAssociate,"NW_GENERIC_LAST_ATTACK_TARGET")==oTarget)
        { // abort attack
            DetermineCombatRound();
        } // abort attack
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,nN);
    } // summoned
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // familiar
        SetIsTemporaryNeutral(oAssociate,oTarget);
        SetIsTemporaryNeutral(oTarget,oAssociate);
        if (GetLocalObject(oAssociate,"NW_GENERIC_LAST_ATTACK_TARGET")==oTarget)
        { // abort attack
            DetermineCombatRound();
        } // abort attack
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,nN);
    } // familiar
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // animal companion
        SetIsTemporaryNeutral(oAssociate,oTarget);
        SetIsTemporaryNeutral(oTarget,oAssociate);
        if (GetLocalObject(oAssociate,"NW_GENERIC_LAST_ATTACK_TARGET")==oTarget)
        { // abort attack
            DetermineCombatRound();
        } // abort attack
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC,nN);
    } // animal companion
    nN=1;
    oAssociate=GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC,nN);
    while(GetIsObjectValid(oAssociate))
    { // dominated
        SetIsTemporaryNeutral(oAssociate,oTarget);
        SetIsTemporaryNeutral(oTarget,oAssociate);
        if (GetLocalObject(oAssociate,"NW_GENERIC_LAST_ATTACK_TARGET")==oTarget)
        { // abort attack
            DetermineCombatRound();
        } // abort attack
        nN++;
        oAssociate=GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC,nN);
    } // dominated
} // DLA_AdjustFactionAssociates()
