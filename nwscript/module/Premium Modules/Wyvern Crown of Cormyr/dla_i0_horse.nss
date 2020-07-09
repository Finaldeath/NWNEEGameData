//::///////////////////////////////////////////////
//:: dla_i0_horse
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Include file of DLA Horse system.
   Includes all mounting, unmounting and acessory functions
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: May 22, 2005
//:://////////////////////////////////////////////

//:: PATCH VERSION HISTORY
//::mm/dd/yyyy | MODIFIED BY      | DESCRIPTION
//::09/15/2006 | Deva B. Winblood | Patch 1 - made it so Paladin Mount will
//             |                  | not destpawn/unsummon in the jousting area.
//::           |                  | Mantis # 2126
//::10/11/2006 | Deva B. Winblood | Patch 1 - removed the above fix from here
//             |                  | it is handled in dla_hrs_heart now

//for the displacement of the horse when unmounting
#include "x0_i0_position"

//for RemoveSpecificEffect function
#include "nw_i0_spells"

#include "x0_inc_henai"

//for SetAssociateState function
#include "nw_i0_generic"

//for special behaviour and accessory functions
#include "dla_i0_horseai"

//constants that define options on DLA Horse System
#include "dla_i0_switches"

//general use constants
#include "dla_i0_const"

//Syrsnein 9 Feb 2006: Debug
#include "dla_i0_debug"

//Deva B. Winblood  Jun 23rd 2006 - wrapped all mounting related stuff in
// external include...
#include "dla_i0_mount"

const int DLA_HORSE_DEBUG           = TRUE;

void DLA_HorseDebug(string sMessage, int bForce=FALSE)
{
    if (!DLA_HORSE_DEBUG && !bForce) return;
    DLA_Debug("[DLA HORSE DEBUG] " + sMessage);
}

// FILE: dla_i0_horse
// This function returns TRUE if the specified oHenchman is a paladin's horse.
int DLA_GetIsPaladinMount(object oHenchman);

// FILE: dla_i0_horse
// This function returns TRUE if the specified oPlayer already has a paladin's
// mount.
int DLA_GetHasPaladinMount (object oPlayer);

// Gale 22 May 2005:
// Mounts oCreature in a horse of type nHorse
// plays mounting animation DIRGE 31/05/05: now destroying the original horse when mounted.
// - nHorse: DLA_HORSE?_TAIL_*
// WARNING: oHorse as OBJECT_INVALID should be only used on cutscenes, as when the creature dismounts,
// there will be no horse created.
// Note: DLA_HORSE_TAIL_AUTOMATIC can only be used if oHorse is not OBJECT_INVALID
//void DLA_Mount(object oCreature, object oHorse, int bPlayAnimation=TRUE, int nHorseTail=DLA_HORSE_TAIL_AUTOMATIC);

// Gale 22 May 2005:
// Dismounts oCreature from horse.
// Playing dismount animation and creating a dismounted horse creature
// Gale 1 May 2006: Changed return type. now returns the horse created.
// Syrsnein 8 July 2006: removed return type
void DLA_Dismount (object oCreature, int bPlayAnimation = TRUE, int bAddAsHenchman = TRUE, int bHitchHorse = FALSE, object oNewOwner = OBJECT_INVALID);

// Gale June 2005:
// Increase / Decrease movement speed based on if oCreature is mounted
void DLA_RefreshMovementSpeed(object oCreature);

// Gale 3 Dec 2005:
// Apply / Remove the penalty for using ranged weapons while mounted.
// Takes in account the feat Mounted Archery
void DLA_RefreshMountedArcheryPenalty();

// Gale 3 Nov 2005:
//Creates a horse near to oPC and charge for it's price based on DLA_PRICE_* const
//iHorseVar (DLA_TEMPLATE_*)
//iBarding  (DLA_HORSE_BARDING_*)
//iColor    (DLA_HORSE_COLOR_*)
void DLA_BuyHorse(int iHorseVar, object oPC, int iBarding, int iColor, int nForFree = FALSE);

// Gale June 2005:
// Change oCreature to original appearance type and phenotype.
// Also sets the creature as unmounted.
void DLA_ChangeToOriginalAppearance(object oCreature);

// Gale June 2005:
// Stores the current hit points of the horse on the object oCreature. Meant to
// be used as part of the mounting functions so that the horse henchman's HP can
// be properly tracked.
// Return stored HP of the horse associated with oCreature
// Changes the appearance of oCreature to one of the horse types.
void DLA_ChangeToMountedAppearance(object oCreature);

// Gale 22 May 2005:
// Returns TRUE if oCreature is mounted on a horse
int DLA_GetIsMounted(object oCreature);

// Gale Nov 2005:
// Plays Mounting animation of oCreature
void DLA_PlayMountAnimation(object oCreature);

// Gale Nov 2005:
// Plays dismounting animation of oCreature
void DLA_PlayDismountAnimation(object oCreature);

// Gale Nov 2005:
// Returns the appearance type when unmounted of oCreature
// * returns a constant APPEARANCE_TYPE_* for valid creatures
// * returns APPEARANCE_TYPE_INVALID for non creatures/invalid creatures/non mounted creatures
int DLA_GetOriginalAppearanceType(object oCreature);

// Gale Nov 2005:
// Returns the original phenotype when NOT mounted of oCreature
int DLA_GetOriginalPhenotype(object oCreature);

// Gale Nov 2005:
// Returns the appropriate appearance type to make oCreature when mounted
// * returns a constant DLA_HORSE_APPEARANCE_* for valid creatures
// * returns oCreature current appearance constant for non creatures/invalid creatures
int DLA_GetHorseAppearanceType(object oCreature);

// Gale Nov 2005:
// Increases movement of creature by factor of 99--effect is permanent, not
// removed with resting or with dispels
void DLA_IncreaseMovementSpeed(object oCreature);

// Gale Nov 2005:
// Sets the creature back to their original movement speed by removing the
// permanent speed increase applied in DLA_IncreaseMovementSpeed
void DLA_OriginalMovementSpeed(object oCreature);

// Gale Nov 2005:
// Return TRUE if the area is NOT an interior, or if the area has a variable set
// on it, indicating it is an OK interior for horses to be in.
int DLA_GetIsInteriorAllowed(object oArea);

// Gale Nov 2005:
// Add horse tail of type nHorse to oCreature
//- nHorse: DLA_HORSE*_TAIL_*
void DLA_AddHorseTail(object oCreature, int nHorse);

// Gale Nov 2005:
// Remove Horse tail from oCreature, set to none
void DLA_RemoveHorseTail(object oCreature);

// Gale Nov 2005:
// Removes the skill penaulty applied to oCreature while on horseback
void DLA_RemoveSkillDecrease(object oCreature);

//Gale 6 Dec 2005
//Wraper function, to allow the use of functions returning object during
//DelayCommand calls, wich expect to have a void delayed.
void DLA_ObjectToVoid(object oObject){}

//Syrsnein Mar 2006
//Wrapper function to allow the use of functions returning int during
//DelayCommand calls.
void DLA_IntToVoid(int i){}

// Gale Nov 2005:
//Returns true if oHorse is a horse, and has packs.
//Returns false otherwise.
int DLA_GetHasPacks(object oHorse);

// Gale Nov 2005:
//Creates the horse creature equivalent to the one oCreature was riding
//return the object created. if no horse was being rided, return OBJECT_INVALID
//OBS.: Using DLA_Mount on a invalid horse, result on not being able to
//create the dismounted horse. in this case, this function will return OBJECT_INVALID
//and do nothing.
object DLA_CreateDismountedHorse(object oCreature, int bAddAsHenchman = TRUE, int bHitchHorse = FALSE, object oNewOwner = OBJECT_INVALID);

// Gale Nov 2005:
// Returns the number of the horse tail based on the appearance type... if not
// a horse-designed appearance, returns APPEARANCE_TYPE_INVALID.
//int DLA_GetMountedHorseType(object oHorse);

// Gale Nov 2005:
// Sets oHenchman as a henchman of oMaster;
// if IncMaxHenchIfNeeded is set to TRUE, will expand the number of henchman
// possible by 1 to do so if need be.
void DLA_SetHenchman(object oHenchman, object oMaster, int bIncMaxHenchIfNeeded = TRUE, int bChangeName=TRUE);

// Gale Nov 2005:
// Returns TRUE if creature appearance matches to one of DLA's horse appearances
// OR if the creature is our 'invisible horse henchman'. Else FALSE is returned.
int DLA_GetIsDLAHorse(object oCreature);

// Gale Nov 2005:
// Takes the gold of the appropriate amount for the horse from the buyer
void DLA_TakeGoldFromHorseBought(object oPC, int iHorseVar);

// Gale Nov 2005:
// Returns the amount the horse is to be charged for
int DLA_GetHorsePrice(int iHorseVar);

// Dirge Nov 10 2005:
// Takes the current appearance of the horse that has just been created, gets
// the texture and barding variables from the PC, changes the horse's appearance
// to match what the PC asked for. Note that walnut is the default appearance...
// no reason to change horse appearance -to- walnut, it already is.
void DLA_SetHorseAppearance(object oHorse, object oPC, int iBarding = DLA_HORSE_BARDING_TYPE_NONE, int iColor = DLA_HORSE_COLOR_WALNUT);

// Gale Nov 2005:
// Set the horse portrait corresponding to oHorse appearance
void DLA_SetHorsePortrait(object oHorse);

//Gale Nov 28, 2005
//Force OBJECT_SELF to REALLY unequip oItem
//Note: ClearAllActions is used inside of this function
void DLA_ForceUnequip(object oItem);

//Gale Nov 16, 2005
//Unequips large weapons that clips when mounted on horse
void DLA_UnequipForbiddenWeapon(object oPC, object oItem=OBJECT_INVALID);

//Gale Nov 16, 2005
//Unequips shields, as they clip badly on horses and had nodes on animation removed
void DLA_UnequipShield(object oPC, object oItem=OBJECT_INVALID);

//Gale Nov 16, 2005
//Wraps proccess of horse destruction, wich by now includes having it invisible
//before really destroying and setting it to be destroyable
void DLA_DestroyHorseHenchman(object oPlayer, object oHorse);

//Deva B. Winblood  Jun 22, 2006
//Wraps Animation Sequence for Mount
void DLA_MountSequence(object oCreature, int nHorse,object oHorse,int nCount=1);

//Gale Nov 13, 2005
//Returns the number of horses owned by oMaster. Includes any henchman horse and
//and horse currently being mounted
int DLA_GetNumHorsesOwned(object oMaster);

//Gale 23 Nov, 2005
//Get the horse henchman belonging to oMaster
//Return OBJECT_INVALID if oMaster don't have nNth horse henchmen.
//nNth: wich henchman to return
//OBS: THIS FUNCTION DON'T ALLOW ACCESS TO HORSES CURRENTLY BEING MOUNTED
object DLA_GetHorseHenchman(object oMaster, int nNth=1);

//Gale 4 Dec 2005:
//Remove oHenchman as a henchman from oMaster
//if bReset is TRUE, the name is reseted to it's original
//if bSetAsFormerMaster is set as TRUE, nwn original leave party function
//instead of a simple RemoveHenchman. (includes setting oMaster as former master, etc)
void DLA_RemoveHenchman(object oMaster, object oHenchman=OBJECT_SELF, int bResetName = TRUE, int bSetAsFormerMaster = FALSE);

//Gale Dec 10, 2005:
//Wrapper to make oCreature name include information about it's owner
void DLA_IncludeOwnerOnCreatureName(object oOwner, object oCreature);

// Gale 12 Feb 2006 - Note: Remember to kill whoever named the function that way
// I will not change the function name to don't break functions / scripts expected behaviour.
// This functions don't check if oPC is a warhorse, only if it's mounted on a warhorse.
// To actually check if the creature is a warhorse, use the function DLA_GetHorseIsWarHorse
// Return whether the PC is riding a warhorse or not
// Syrsnein - 26 Mar 2006: Took the plunge, copied and renamed to DLA_GetMountIsWarhorse
//  and changed this function to return if the passed creature is a warhorse.
int DLA_GetIsWarhorse(object oCreature);

//Syrsnein 26 Mar 2006 -
//Returns TRUE if the horse mounted by oPC is a warhorse.
//Returns FALSE if oPC is not mounted or if the horse is not a warhorse
int DLA_GetMountIsWarhorse(object oPC);

//Gale 8 Feb 2006:
//Returns TRUE if oCreature have at least one warhorse
//Checks horses both being mounted by oCreature, or any of his/her henchman
//and horses not currently mounted.
int DLA_GetHasWarHorse(object oCreature);

//Gale 12 Feb 2006:
//Returns TRUE if oCreature is a horse owned by a PC or by one associate of a PC
int GetHorseOwnerIsAssociateOrPC(object oCreature);

//Gale 23 Feb 2006:
void DLA_ReturnOwnedHorsesOnAreaToPCParty(object oPC, object oArea=OBJECT_INVALID);

//Syrsnein 8 March 2006: Return the first warhorse that oCreature owns
object DLA_GetWarhorse(object oCreature, int Nth=1, int bPlayAnimation=FALSE);


//Gale April 2006:
//Removes all horse being mounted by any of oCreature's henchmen
//Return TRUE if remove at least one horse, and FALSE otherwise.
//Recursive function. Does the same to each henchmen.
int DLA_RemoveAllHenchmenHorses(object oCreature, object oHitchingPost=OBJECT_INVALID, int bAnimation=TRUE);

//Gale 28 April 2006: Returns to lacinda the horse owned by oLacinda that was borrowed to oPC
//used on quest where PC borrows her horse.
//If it's currently being mounted by someone, dismounts the creature then returns the horse.
void DLA_ReturnLacindasHorse(object oPC, object oLacinda);

//Gale 28 April 2006: Removes all horses from party, and dismount all party members.
//Horses stay where they are.
//Used on rope script, to avoid having horses crossing on ropes.
int DLA_RemovePartyHorsesAndLeaveOnPlace(object oPC);

// Deva B. Winblood 5/6/2006:
// This function will set the horse specified to untied it will also remove any
// tied horse map waypoints associated with it.  If the tied horse does not
// appear to have such a waypoint it will browse the module and check all such
// waypoints to make sure one was not assigned to this horse but, the relationship
// severed somehow.
void DLA_UntieHorse(object oHorse);

// Deva B. Winblood 5/6/2006:
// This function will return a unique number to identify this horse.  It can then
// be used to explicitly link some variables on the module to a specific
// instance of a horse even when it is recreated by dismount and such.
int DLA_GetHorseID();

// Deva B. Winblood 5/6/2006:
// This function is private and is only called by DLA_Mount.
// Transfer equipment from horse packs to a temporary storage
void DLA_Horse_TransferEquipment(object oHorse,object oCreature);

// Deva B. Winblood 5/24/2006:
// This function is private and is only called by DLA_Mount.
// Finalize mounting sequence, handling skill penalty on horseback and footstep sound
void DLA_Horse_FinalizeMounted(object oCreature,object oHorse);

// Deva B. Winblood 5/24/2006:
// This function is private and is only called by DLA_Mount.
// Play the mounting animation
void DLA_Horse_AnimateMounting(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail);

// Deva B. Winblood 5/6/2006:
// This preserves information needed by dismount
void DLA_Horse_PreserveMountInfo(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail);

// Deva B. Winblood 5/6/2006:
// Prepares the creature and horse to play the mounting animation
void DLA_Horse_PrepMountAnimation(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail);

// Deva B. Winblood 5/6/2006:
// When called, this function fires every 6 seconds until the creature is successful
// at mounting.
void DLA_Horse_MonitorMountSuccess(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail);

// FILE: dla_i0_horse   Deva B. Winblood  6/14/2006
// This function will return TRUE if oCreature is not one of the default
// racial appearances.   Use this to prevent functions that should only
// be called from standard appearances from executing at improper time.
int DLA_Horse_GetIsNotDefaultAppearance(object oCreature);

// FILE: dla_i0_horse   Deva B. Winblood  6/17/2006
// This function will recursively call itself with delays until all items
// carried by oCreature have been successfully dropped.  bStarted does not
// need to be set by scripters.
void DLA_Horse_DropInventory(object oCreature,int bStarted=FALSE);

// FILE: dla_i0_horse    Deva B. Winblood  6/17/2006
// Drop items on ground and then despawn.
void DLA_DespawnPaladinMount(object oMount,int nKey=0);

// Counts up the horses in the area owned by the PC
// B G P Hughes 11/08/08
int DLA_CountOwnedHorsesInArea(object oPC,object oArea=OBJECT_INVALID, int nTiedOnly=FALSE);

///////////////////////////////////////////////
/////// End of headers declarations ///////////
///////////////////////////////////////////////

int DLA_GetIsMounted(object oCreature)
{
    //Gale 31/05/05: Using constants to refer to phenotype. if - else taken out.
    int iPheno = GetPhenoType(oCreature);
    return iPheno == PHENOTYPE_DLA_MOUNTED_NORMAL ||
           iPheno == PHENOTYPE_DLA_MOUNTED_BIG
//Gale 9 jan 2006 : As jousting pheno is used only for cutscenes, don't check for it.
//           ||
//           iPheno == PHENOTYPE_DLA_JOUSTING_NORMAL ||
//           iPheno == PHENOTYPE_DLA_JOUSTING_BIG
           ;
}

int DLA_GetOriginalAppearanceType(object oCreature)
{
    // DIRGE 31/05/05: Now working off of checks for which custom pheno it is.
    switch(GetAppearanceType(oCreature))
    {
        case DLA_HORSE_APPEARANCE_DWARF_FEMALE    : return APPEARANCE_TYPE_DWARF;
        case DLA_HORSE_APPEARANCE_ELF_FEMALE      : return APPEARANCE_TYPE_ELF;
        case DLA_HORSE_APPEARANCE_GNOME_FEMALE    : return APPEARANCE_TYPE_GNOME;
        case DLA_HORSE_APPEARANCE_HALFLING_FEMALE : return APPEARANCE_TYPE_HALFLING;
        case DLA_HORSE_APPEARANCE_HALF_ELF_FEMALE : return APPEARANCE_TYPE_HALF_ELF;
        case DLA_HORSE_APPEARANCE_HALF_ORC_FEMALE : return APPEARANCE_TYPE_HALF_ORC;
        case DLA_HORSE_APPEARANCE_HUMAN_FEMALE    : return APPEARANCE_TYPE_HUMAN;

        case DLA_HORSE_APPEARANCE_DWARF_MALE    : return APPEARANCE_TYPE_DWARF;
        case DLA_HORSE_APPEARANCE_ELF_MALE      : return APPEARANCE_TYPE_ELF;
        case DLA_HORSE_APPEARANCE_GNOME_MALE    : return APPEARANCE_TYPE_GNOME;
        case DLA_HORSE_APPEARANCE_HALFLING_MALE : return APPEARANCE_TYPE_HALFLING;
        case DLA_HORSE_APPEARANCE_HALF_ELF_MALE : return APPEARANCE_TYPE_HALF_ELF;
        case DLA_HORSE_APPEARANCE_HALF_ORC_MALE : return APPEARANCE_TYPE_HALF_ORC;
        case DLA_HORSE_APPEARANCE_HUMAN_MALE    : return APPEARANCE_TYPE_HUMAN;
    }
    // Deva Winblood - 8/03/2006 - Stop problems with invalid appearances
    switch(GetRacialType(oCreature))
    {
        case RACIAL_TYPE_DWARF:    return APPEARANCE_TYPE_DWARF;
        case RACIAL_TYPE_ELF:      return APPEARANCE_TYPE_ELF;
        case RACIAL_TYPE_GNOME:    return APPEARANCE_TYPE_GNOME;
        case RACIAL_TYPE_HALFLING: return APPEARANCE_TYPE_HALFLING;
        case RACIAL_TYPE_HALFELF:  return APPEARANCE_TYPE_HALF_ELF;
        case RACIAL_TYPE_HALFORC:  return APPEARANCE_TYPE_HALF_ORC;
        case RACIAL_TYPE_HUMAN:    return APPEARANCE_TYPE_HUMAN;
    }
    return APPEARANCE_TYPE_INVALID;
}

void privateForceEquip(object oCreature,object oShield)
{ // PURPOSE: make sure it is equipped
    object oEquipped=GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oCreature);
    if(oEquipped!=oShield&&GetItemPossessor(oShield)==oCreature)
    { // equip
        AssignCommand(oCreature,ActionEquipItem(oShield,INVENTORY_SLOT_LEFTHAND));
        DelayCommand(3.0,privateForceEquip(oCreature,oShield));
    } // equip
    else
    { // equipped
        DeleteLocalObject(oCreature,"oMountedShield");
    } // equipped
} // privateForceEquip()

void DLA_ChangeToOriginalAppearance(object oCreature)
{
    object oShield=GetLocalObject(oCreature,"oMountedShield");
    SetCreatureAppearanceType(oCreature, DLA_GetOriginalAppearanceType(oCreature));
    SetPhenoType(DLA_GetOriginalPhenotype(oCreature), oCreature);
    SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,oCreature);
    if (GetIsObjectValid(oShield)&&GetItemPossessor(oShield)==oCreature)
    { // equip
        DelayCommand(1.5,privateForceEquip(oCreature,oShield));
    } // equip
}

int DLA_GetOriginalPhenotype(object oCreature)
{
    //Gale 31/05/05: Using constants to refer to phenotype.
    switch(GetPhenoType(oCreature))
    {
        //if custom riding 'normal' size pheno
        //set to return normal pheno as original
        case PHENOTYPE_DLA_MOUNTED_NORMAL: return PHENOTYPE_NORMAL;
        //if custom riding 'large' size pheno
        //set to return large pheno as original
        case PHENOTYPE_DLA_MOUNTED_BIG: return PHENOTYPE_BIG;
    }
    return GetPhenoType(oCreature);
}

void DLA_AddHorseTail(object oCreature, int nHorse)
{
    int nTail=nHorse;
    DLA_HorseDebug("DLA_AddHorseTail("+GetName(oCreature)+","+IntToString(nHorse));
    if (nTail<4)
    { // recover from invalid tail
       nTail=GetLocalInt(oCreature,"nUseTail");
       DLA_HorseDebug("   bad tail try:"+IntToString(nTail));
    } // recover from invalid tail
    SetCreatureTailType(nTail, oCreature);
}

void DLA_RemoveHorseTail(object oCreature)
{
    SetCreatureTailType(CREATURE_TAIL_TYPE_NONE, oCreature);
}

void DLA_DestroyHorseHenchman(object oPlayer, object oHorse)
{
    effect eCutSceneInvisible = SupernaturalEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutSceneInvisible, oHorse);
    RemoveHenchman( oPlayer, oHorse );
    AssignCommand(oHorse, SetIsDestroyable(TRUE, FALSE, FALSE));
    DestroyObject( oHorse, 0.1 );
}


void privateDLA_MountSequence(object oCreature,int nHorse,object oHorse)
{ // PURPOSE: Mount Sequence portion to run after movement to location has
  // been verified
  // Added June 22, 2006 - Deva B. Winblood
     effect eInvis=EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
     DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oHorse,8.0));
     DelayCommand(4.6,DLA_ChangeToMountedAppearance(oCreature));
     DelayCommand(4.65,DLA_AddHorseTail(oCreature,nHorse));
     DelayCommand(6.5,SetLocalInt(oHorse,"bDLAMountDespawn",TRUE));
     DLA_PlayMountAnimation(oCreature);
     AssignCommand(oCreature,ActionDoCommand(DLA_AddHorseTail(oCreature,nHorse)));
     AssignCommand(oCreature,ActionDoCommand(DLA_ChangeToMountedAppearance(oCreature)));
     AssignCommand(oCreature,ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oHorse,8.0)));
     DelayCommand(4.5,AssignCommand(oCreature,DLA_RefreshMovementSpeed(oCreature)));
     DelayCommand(4.7,AssignCommand(oCreature,DLA_RefreshMountedArcheryPenalty()));
} // privateDLA_MountSequence()


void DLA_MountSequence(object oCreature, int nHorse,object oHorse,int nCount=1)
{ // PURPOSE: This function will move the mounter first.  It will
  // keep trying.  If for some reason mounter cannot move to location on even
  // calls it will move the horse.  Once positioning is properly setup it
  // will call privateDLA_MountSequence() to continue the animating.  It was
  // setup this way to retain the "horse hat" fix and eliminate blinking that
  // was reported in mantis #1720.
        location lLoc;
        if (nCount%3>0)
        { // move oCreature
           lLoc=DLA_Horse_GetAnimationProxyLocation(oHorse,-90.0);
           if (GetDistanceBetweenLocations(GetLocation(oCreature),lLoc)>0.1)
           { // jump
               AssignCommand(oCreature,ClearAllActions(TRUE));
               AssignCommand(oCreature,JumpToLocation(lLoc));
               DelayCommand(0.05,DLA_MountSequence(oCreature,nHorse,oHorse,nCount+1));
           } // jump
           else
           { // positioned ok
               DelayCommand(0.05,privateDLA_MountSequence(oCreature,nHorse,oHorse));
           } // positioned ok
        } // move oCreature
        else
        { // move oHorse
           lLoc=DLA_Horse_GetAnimationProxyLocation(oCreature);
           if (GetDistanceBetweenLocations(GetLocation(oHorse),lLoc)>0.1)
           { // jump
              AssignCommand(oHorse,ClearAllActions(TRUE));
              AssignCommand(oHorse,JumpToLocation(lLoc));
              DelayCommand(0.05,DLA_MountSequence(oCreature,nHorse,oHorse,nCount+1));
           } // jump
           else
           { // positioned ok
               DelayCommand(0.05,privateDLA_MountSequence(oCreature,nHorse,oHorse));
           } // positioned ok
        } // move oHorse
}


void DLA_RemoveSkillDecrease(object oCreature)
{
        effect ePenalty = GetFirstEffect(OBJECT_SELF);
        while (GetIsEffectValid(ePenalty))
        {
           if ((GetEffectType(ePenalty) == EFFECT_TYPE_SKILL_DECREASE) &&
           (GetEffectSubType(ePenalty) == SUBTYPE_SUPERNATURAL) &&
           (GetEffectDurationType(ePenalty) == DURATION_TYPE_PERMANENT))
           {
               RemoveEffect(OBJECT_SELF, ePenalty);
           }
           ePenalty = GetNextEffect(OBJECT_SELF);
        }
}



void DLA_DismountForce(object oRider)
{ // PURPOSE: This will force the dismounted rider to be in the proper phenotype

     SetPhenoType(GetLocalInt(oRider,"nDLAAltPheno"),oRider);
     DelayCommand(0.4,SetPhenoType(GetLocalInt(oRider,"nDLADefaultPheno"),oRider));

} // DLA_DismountForce()


// Dismounts oCreature from horse.
// Playing dismount animation and creating a dismounted horse creature
void DLA_Dismount (object oCreature, int bPlayAnimation = TRUE, int bAddAsHenchman = TRUE, int bHitchHorse = FALSE, object oNewOwner = OBJECT_INVALID)
{
    int bIsInCutscene = GetCutsceneMode(oCreature);
    object oHorse;

    oHorse=GetLocalObject(oCreature,"oDLAMyMount"); // Deva  6/28/2006

    // Deva Winblood  6/23/2006 - Support for global no animation switch
    if (GetLocalInt(GetModule(),"bDLAHorseNoAnimate")) bPlayAnimation=FALSE;

    DLA_HorseDebug("DLA_Dismount("+GetName(oCreature)+") sDLA_Horse='"+GetLocalString(oCreature,"sDLA_Horse")+"'");
//Gale 19 April 2006: No need to mess with max henchmen on this function
//It's handled on DLA_SetHenchman
//    SetMaxHenchmen(GetMaxHenchmen()+1);
    DLA_RemoveSkillDecrease(oCreature);
    if (bPlayAnimation)
    { // play animation
        //Takamura 08.09.2005: SetcutsceneMode only if creature is
        //not already in cutscenemode
        if (!bIsInCutscene)
           SetCutsceneMode(oCreature);

        AssignCommand(oCreature, ClearAllActions(FALSE));
        //Gale 3 Dec 2005: As we changed implementation, no point in clearing combat flag
        SetFootstepType(FOOTSTEP_TYPE_NORMAL, oCreature);

        DelayCommand(1.0, DLA_PlayDismountAnimation(oCreature));
        DelayCommand(4.0, DLA_ChangeToOriginalAppearance(oCreature));
        //DelayCommand(3.0, DLA_RemoveHorseTail(oCreature));
//        DelayCommand(3.6,
//              AssignCommand(oCreature,
//                    JumpToLocation(GetStepLeftLocation(oCreature))));
        DelayCommand(4.4, DLA_ObjectToVoid(oHorse = DLA_CreateDismountedHorse(oCreature, bAddAsHenchman, bHitchHorse, oNewOwner)));
        DelayCommand(4.5, DLA_RefreshMovementSpeed(oCreature));
        DelayCommand(4.5, AssignCommand(oCreature, DLA_RefreshMountedArcheryPenalty()));
        // Deva Winblood 6/23/2006 - added following to account for engine lag problems
        //DelayCommand(3.1, SetCreatureTailType(DLA_HORSE_TAIL_NULL_TAIL,oCreature));
        //DelayCommand(3.2, SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,oCreature));
        //DelayCommand(2.7, SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,oCreature));
        //Gale 02/06/05: Longer delay before canceling cutscene mode to fix naked bug
        if (!bIsInCutscene)
            DelayCommand(3.7, SetCutsceneMode(oCreature, FALSE));
        //DeleteLocalObject(oCreature,"oDLAMyMount");
    } // play animation
    else
    { // don't play animation
        //Gale 3 Dec 2005:
        //Really implemented the parameter bPlayAnimation
        //DIRGE 01/06/05: Need to take them out of combat even... also, rare bug where
        //player becomes naked briefly, didn't happen before...
        AssignCommand(oCreature, ClearAllActions(FALSE));

        SetFootstepType(FOOTSTEP_TYPE_NORMAL, oCreature);
        DLA_ChangeToOriginalAppearance(oCreature);
        //DLA_RemoveHorseTail(oCreature);
        oHorse = DLA_CreateDismountedHorse(oCreature, bAddAsHenchman, bHitchHorse, oNewOwner);
        //DeleteLocalObject(oCreature,"oDLAMyMount");
        DelayCommand(0.1, DLA_RefreshMovementSpeed(oCreature));
        DelayCommand(0.1, AssignCommand(oCreature, DLA_RefreshMountedArcheryPenalty()));
    } // don't play animation
    //DelayCommand(5.1,DLA_DismountForce(oCreature));
//Syrsnein, 8 July 06, no return object needed    return oHorse;
  DelayCommand(12.5,DeleteLocalInt(oCreature,"bLacindasOwnedHorse"));
  DelayCommand(5.0,DeleteLocalInt(oCreature,"bDismounting"));
  DelayCommand(24.0,DeleteLocalString(oCreature,"sHorseTag"));
  DeleteLocalInt(oCreature,"bHorseActionActive");
}

int DLA_GetHorseAppearanceType(object oCreature)
{
    if (GetGender(oCreature) == GENDER_MALE)
    {

        switch(GetAppearanceType(oCreature))
        {
            case APPEARANCE_TYPE_DWARF         : return DLA_HORSE_APPEARANCE_DWARF_MALE;
            case APPEARANCE_TYPE_ELF           : return DLA_HORSE_APPEARANCE_ELF_MALE;
            case APPEARANCE_TYPE_GNOME         : return DLA_HORSE_APPEARANCE_GNOME_MALE;
            case APPEARANCE_TYPE_HALFLING      : return DLA_HORSE_APPEARANCE_HALFLING_MALE;
            case APPEARANCE_TYPE_HALF_ELF      : return DLA_HORSE_APPEARANCE_HALF_ELF_MALE;
            case APPEARANCE_TYPE_HALF_ORC      : return DLA_HORSE_APPEARANCE_HALF_ORC_MALE;
            case APPEARANCE_TYPE_HUMAN         : return DLA_HORSE_APPEARANCE_HUMAN_MALE;
        }
    }
    else
    {
        switch(GetAppearanceType(oCreature))
        {
            case APPEARANCE_TYPE_DWARF         : return DLA_HORSE_APPEARANCE_DWARF_FEMALE;
            case APPEARANCE_TYPE_ELF           : return DLA_HORSE_APPEARANCE_ELF_FEMALE;
            case APPEARANCE_TYPE_GNOME         : return DLA_HORSE_APPEARANCE_GNOME_FEMALE;
            case APPEARANCE_TYPE_HALFLING      : return DLA_HORSE_APPEARANCE_HALFLING_FEMALE;
            case APPEARANCE_TYPE_HALF_ELF      : return DLA_HORSE_APPEARANCE_HALF_ELF_FEMALE;
            case APPEARANCE_TYPE_HALF_ORC      : return DLA_HORSE_APPEARANCE_HALF_ORC_FEMALE;
            case APPEARANCE_TYPE_HUMAN         : return DLA_HORSE_APPEARANCE_HUMAN_FEMALE;
        }
    }

    return GetAppearanceType(oCreature);
}

void DLA_ChangeToMountedAppearance(object oCreature)
{
    DLA_HorseDebug("<DLA_ChangeToMountedAppearance>");
    //DIRGE 31/05/05: need a check for which pheno we are coming from.
    //Gale 31/05/05: Using constants to refer to phenotype
    int iPheno = GetPhenoType(oCreature);
    DLA_HorseDebug("   Pheno Type before change: " + IntToString(iPheno));
    switch (iPheno)
    {
       case PHENOTYPE_DLA_JOUSTING_NORMAL :
       case PHENOTYPE_NORMAL : iPheno = PHENOTYPE_DLA_MOUNTED_NORMAL; break;
       case PHENOTYPE_DLA_JOUSTING_BIG :
       case PHENOTYPE_BIG : iPheno = PHENOTYPE_DLA_MOUNTED_BIG; break;
       default : return;
    }
    DLA_HorseDebug("   Pheno type to change to: " + IntToString(iPheno));
    SetPhenoType(iPheno, oCreature);
    DLA_HorseDebug("   Pheno type after change: " + IntToString(GetPhenoType(oCreature)));

    //Deva Winblood June 16,2006: Moved order of execution to address sinkage
    //Gale Dec 23, 2005: made changes to integrate jousting system
    SetCreatureAppearanceType(oCreature, DLA_GetHorseAppearanceType(oCreature));
}




void DLA_PlayMountAnimation(object oCreature)
{
    //Play mount animation
    // 6/18/2006 - Deva Winblood - Changed duration from 6.0 to 4.7
    AssignCommand(oCreature, ActionPlayAnimation(ANIMATION_DLA_LOOPING_MOUNT, 1.0, 4.7));
}

void DLA_PlayDismountAnimation(object oCreature)
{
    //play dismount animation
    AssignCommand(oCreature, ActionPlayAnimation(ANIMATION_DLA_LOOPING_DISMOUNT, 1.0, 3.5));
}

//Gale 6 Dec 2005
//Changed function from void to object, to return the horse created
// Deva Winblood   May 16, 2006 - Added some steps to insure this horse is
//     created.  There are cases where the horses were vanishing when dismounted
//     by henchmen.
// Deva Winblood   Jun 17, 2006 - Worked on assign mount issues
object DLA_CreateDismountedHorse(object oCreature, int bAddAsHenchman = TRUE, int bHitchHorse = FALSE, object oNewOwner = OBJECT_INVALID)
{
    object oHorse = OBJECT_INVALID;
    string sResRef = GetLocalString( oCreature, "sDLA_Horse" );
    object oHitchingPost;
    int nID;
    int bIsInNoMountArea = GetLocalInt(oCreature, "DLA_CANT_MOUNT");
    object oPacks;
    location lDestination;
    object oItem;
    object oHorseOwner;
    object oHitch;
    effect eDamage;
    string sTag=GetLocalString(oCreature,"sHorseTag");
    object oAssigned=GetLocalObject(oCreature,"oDLAHorseAssigned");

    oHorse=GetLocalObject(oCreature,"oDLAMyMount"); // Deva  6/28/2006

    DLA_HorseDebug("  DLA_CreateDismountedHorse("+GetName(oCreature)+","+IntToString(bAddAsHenchman)+","+IntToString(bHitchHorse)+","+GetName(oNewOwner)+")");
    DLA_HorseDebug("       oDLAHorseAssigned='"+GetName(oAssigned)+"'");
    DLA_HorseDebug("       Stored Tag:'"+sTag+"'");
    DLA_HorseDebug("       Stored ResRef:'"+sResRef+"'");
    if (GetLocalInt(GetMaster(oCreature), "DLA_CANT_MOUNT") || bHitchHorse )
        bIsInNoMountArea = TRUE;

    if (GetStringLength(sResRef)>0)
    { // has a resref
        if (bIsInNoMountArea)
        { // in a no mount area
           oHitchingPost = GetNearestObjectByTag(DLA_TAG_HITCHING_POST);
           lDestination = GetLocation(oHitchingPost);
        } // in a no mount area
        else
          lDestination = GetStepRightLocation(oCreature);

        if (!GetIsObjectValid(oHorse)&&(sTag=="LacHorse"||GetStringLength(sTag)<1))
        { // stored horse does not exist
            DLA_HorseDebug("   Recreate Lacinda's Horse");
            oHorse = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lDestination  , FALSE, sTag);
            /*while (!GetIsObjectValid(oHorse))
            { // create this horse - make sure it does not fail
              oHorse = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oCreature)  , FALSE, sResRef);
            } // create this horse - make sure it does not fail   */ // could cause dupe horses
            SetLocalObject(oHorse,"oAssigned",oAssigned);
            DLA_HorseDebug("       oAssigned='"+GetName(GetLocalObject(oHorse,"oAssigned"))+"'");
            SetLocalObject(oAssigned,"oAssigned",oHorse);
            SetCreatureAppearanceType( oHorse, GetLocalInt( oCreature, "iDLA_Horse_App" ) );
            // Deva Winblood   Jun 18, 2006 - deal with paladin despawn town
            if (DLA_GetIsPaladinMount(oHorse))
            { // set despawn timer
              SetLocalInt(oHorse,"nDespawnHour",GetLocalInt(oCreature,"nPalHorseDespawnTime"));
            } // set despawn timer
            // Deva Winblood   May 11, 2006 - create ID that can be used to handle
            // some issues that have appeared.
            nID = GetLocalInt(oCreature,"nHorseID");
            DeleteLocalInt(oCreature,"nHorseID");
            SetLocalInt(oHorse,"nID",nID);
            DLA_SetHorsePortrait(oHorse);

            if (GetLocalInt(oCreature,"bLacindasOwnedHorse"))
            { // lacindas
               SetLocalInt(oHorse,"bLacindasOwnedHorse",TRUE);
               SetLocalString(oHorse,"DLA_TAG_HORSE_NPC_OWNER","Lacinda");
            } // lacindas

            oPacks = GetLocalObject(oCreature, "dla_horse_packs");

            if (GetIsObjectValid(oPacks))
            {
                oItem = GetFirstItemInInventory(oPacks);
                while (GetIsObjectValid(oItem))
                {
                     CopyItem(oItem, oHorse, TRUE);
                     SetDroppableFlag(oItem, FALSE);
                     oItem = GetNextItemInInventory(oPacks);
                }
                SetPlotFlag(oPacks, FALSE);
                DestroyObject(oPacks);
                DeleteLocalObject(oCreature, "dla_horse_packs");
            }

            //Gale 11 June 2006: Adding support for new parameter oNewOwner
            //from DLA_Dismount
            if (GetIsObjectValid(oNewOwner))
              oHorseOwner = oNewOwner;
            else
              oHorseOwner = GetLocalObject(oCreature, "oDLA_HORSE_OWNER");
            SetLocalObject(oHorse,"oDLA_HORSE_OWNER",oHorseOwner);
        } // store horse does not exist
        else if (GetIsObjectValid(oHorse))
        { // retrieve
            DLA_RetrieveHorse(oHorse,lDestination);
            oHorseOwner=GetLocalObject(oHorse,"oDLA_HORSE_OWNER");
            if (GetIsObjectValid(oNewOwner))
            { // set
                 oHorseOwner=oNewOwner;
                 SetLocalObject(oHorse,"oDLA_HORSE_OWNER",oHorseOwner);
            } // set
         } // retrieve

        if (GetIsObjectValid(oHorse))
        { // must have a horse
        //Gale 8 Dec, 2005: Made so that if in "no mount" area, the horse is not
        //Set as henchman to oCreature. instead, it's seted as tied.
        if (!bIsInNoMountArea&&!bHitchHorse)
        { // okay to mount
            if (bAddAsHenchman)
            {
                if (GetIsObjectValid(oHorseOwner))
                      DLA_SetHenchman( oHorse, oHorseOwner );
                else
                      DLA_SetHenchman( oHorse, oCreature );
            }
            else if (!DLA_RESET_NAME_WHEN_REMOVING_ALL_PARTY_HORSES)
                DLA_IncludeOwnerOnCreatureName(oHorseOwner, oHorse);
        } // okay to mount
        else
        {
           if (!DLA_RESET_NAME_WHEN_ON_HITCHING)
                DLA_IncludeOwnerOnCreatureName(oHorseOwner, oHorse);

           SetLocalObject(oHorse, "oDLA_HORSE_OWNER", oHorseOwner);
           nID = GetLocalInt(oHorse,"nID"); // Deva Winblood   May 11, 2006

           if (nID==0)
           { // assign an ID - used for recovery from lost mapnotes
             nID = DLA_GetHorseID();
             SetLocalInt(oHorse,"nID",nID);
             SetLocalObject(GetModule(),"oHorse_Instance_"+IntToString(nID),oHorse);
           }

           DLA_SetIsTied(oHorse);
           oHitch = CreateObject(OBJECT_TYPE_WAYPOINT, "dla_wp_horset002", GetLocation(oHorse));
           SetLocalObject(oHorse, "dla_hitch", oHitch);

           // Deva Winblood   May 11,2006
           SetLocalObject(GetModule(),"oTied_Horse_Mapnote_"+IntToString(nID),oHitch);
           TurnToFaceObject(oHitchingPost, oHorse);
        }

        if (GetTag(oHorse)=="LacHorse"&&bHitchHorse)
        { // make sure not attached to Lacinda
            if(GetIsObjectValid(GetMaster(oHorse))) RemoveHenchman(GetMaster(oHorse),oHorse);
            AssignCommand(oHorse,ClearAllActions(TRUE));
            DLA_SetIsTied(oHorse,TRUE);
        } // make sure not attached to Lacinda

        /*int nHorseHP = GetLocalInt(oCreature, "iDLA_HorseHP");
           if (nHorseHP)
           {
              eDamage = EffectDamage(
                             GetCurrentHitPoints(oHorse) - nHorseHP,
                             DAMAGE_TYPE_DIVINE , DAMAGE_POWER_ENERGY );
             AssignCommand( oHorse, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oHorse));
           }   */

       if (GetLocalInt(oCreature, "bLacindasOwnedHorse"))
              SetLocalInt(oHorse, "bLacindasOwnedHorse", TRUE);

       //DeleteLocalInt(oHorse, "bLacindasOwnedHorse");
       DeleteLocalString( oCreature, "sDLA_Horse");
       DeleteLocalInt( oCreature, "iDLA_Horse_App" );
       DeleteLocalObject(oCreature, "oDLA_HORSE_OWNER");
       DeleteLocalObject(oCreature,"oDLAMyMount");
       DeleteLocalObject(oHorse,"oDLAMyMaster");
       } // if has a horse
    }
    if (GetLocalInt(oCreature,"bDismountDestroy"))
    { // destroy the horse
        DeleteLocalInt(oCreature,"bDismountDestroy");
        DLA_DespawnPaladinMount(oHorse);
    } // destroy the horse
    return oHorse;
}

void DLA_IncreaseMovementSpeed(object oCreature)
{
    effect eMovementIncrease = SupernaturalEffect(EffectMovementSpeedIncrease(DLA_HORSE_SPEED_INCREASE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMovementIncrease, oCreature);
}

void DLA_OriginalMovementSpeed(object oCreature)
{
    effect eSearch = GetFirstEffect(oCreature);
    while(GetIsEffectValid(eSearch))
    {
        if((GetEffectType(eSearch) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE) &&
          (GetEffectDurationType(eSearch) == DURATION_TYPE_PERMANENT) &&
          (GetEffectSubType(eSearch) == SUBTYPE_SUPERNATURAL))
        {
            RemoveEffect(oCreature, eSearch);
        }
        eSearch = GetNextEffect(oCreature);
    }
}

/*int DLA_GetMountedHorseType(object oHorse)
{
    //Dirge 17/06/05: not robe, tail
    switch(GetAppearanceType(oHorse))
    {
        case DLA_HORSE1_APPEARANCE_BAREBACK       : return DLA_HORSE1_TAIL_BAREBACK;
        case DLA_HORSE1_APPEARANCE_SADDLE         : return DLA_HORSE1_TAIL_SADDLE;
        case DLA_HORSE1_APPEARANCE_SADDLE_PACKS   : return DLA_HORSE1_TAIL_SADDLE_PACKS;
        case DLA_HORSE1_APPEARANCE_BARDING1       : return DLA_HORSE1_TAIL_BARDING1;
        case DLA_HORSE1_APPEARANCE_BARDING2       : return DLA_HORSE1_TAIL_BARDING2;
        case DLA_HORSE1_APPEARANCE_BARDING3       : return DLA_HORSE1_TAIL_BARDING3;
        case DLA_HORSE1_APPEARANCE_BARDING4       : return DLA_HORSE1_TAIL_BARDING4;
        case DLA_HORSE1_APPEARANCE_BARDING5       : return DLA_HORSE1_TAIL_BARDING5;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS1 : return DLA_HORSE1_TAIL_BARDING_PACKS1;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS2 : return DLA_HORSE1_TAIL_BARDING_PACKS2;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS3 : return DLA_HORSE1_TAIL_BARDING_PACKS3;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS4 : return DLA_HORSE1_TAIL_BARDING_PACKS4;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS5 : return DLA_HORSE1_TAIL_BARDING_PACKS5;

        case DLA_HORSE2_APPEARANCE_BAREBACK       : return DLA_HORSE2_TAIL_BAREBACK;
        case DLA_HORSE2_APPEARANCE_SADDLE         : return DLA_HORSE2_TAIL_SADDLE;
        case DLA_HORSE2_APPEARANCE_SADDLE_PACKS   : return DLA_HORSE2_TAIL_SADDLE_PACKS;
        case DLA_HORSE2_APPEARANCE_BARDING1       : return DLA_HORSE2_TAIL_BARDING1;
        case DLA_HORSE2_APPEARANCE_BARDING2       : return DLA_HORSE2_TAIL_BARDING2;
        case DLA_HORSE2_APPEARANCE_BARDING3       : return DLA_HORSE2_TAIL_BARDING3;
        case DLA_HORSE2_APPEARANCE_BARDING4       : return DLA_HORSE2_TAIL_BARDING4;
        case DLA_HORSE2_APPEARANCE_BARDING5       : return DLA_HORSE2_TAIL_BARDING5;
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS1 : return DLA_HORSE2_TAIL_BARDING_PACKS1;
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS2 : return DLA_HORSE2_TAIL_BARDING_PACKS2;
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS3 : return DLA_HORSE2_TAIL_BARDING_PACKS3;
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS4 : return DLA_HORSE2_TAIL_BARDING_PACKS4;
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS5 : return DLA_HORSE2_TAIL_BARDING_PACKS5;

        case DLA_HORSE3_APPEARANCE_BAREBACK       : return DLA_HORSE3_TAIL_BAREBACK;
        case DLA_HORSE3_APPEARANCE_SADDLE         : return DLA_HORSE3_TAIL_SADDLE;
        case DLA_HORSE3_APPEARANCE_SADDLE_PACKS   : return DLA_HORSE3_TAIL_SADDLE_PACKS;
        case DLA_HORSE3_APPEARANCE_BARDING1       : return DLA_HORSE3_TAIL_BARDING1;
        case DLA_HORSE3_APPEARANCE_BARDING2       : return DLA_HORSE3_TAIL_BARDING2;
        case DLA_HORSE3_APPEARANCE_BARDING3       : return DLA_HORSE3_TAIL_BARDING3;
        case DLA_HORSE3_APPEARANCE_BARDING4       : return DLA_HORSE3_TAIL_BARDING4;
        case DLA_HORSE3_APPEARANCE_BARDING5       : return DLA_HORSE3_TAIL_BARDING5;
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS1 : return DLA_HORSE3_TAIL_BARDING_PACKS1;
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS2 : return DLA_HORSE3_TAIL_BARDING_PACKS2;
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS3 : return DLA_HORSE3_TAIL_BARDING_PACKS3;
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS4 : return DLA_HORSE3_TAIL_BARDING_PACKS4;
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS5 : return DLA_HORSE3_TAIL_BARDING_PACKS5;

        case DLA_HORSE4_APPEARANCE_BAREBACK       : return DLA_HORSE4_TAIL_BAREBACK;
        case DLA_HORSE4_APPEARANCE_SADDLE         : return DLA_HORSE4_TAIL_SADDLE;
        case DLA_HORSE4_APPEARANCE_SADDLE_PACKS   : return DLA_HORSE4_TAIL_SADDLE_PACKS;
        case DLA_HORSE4_APPEARANCE_BARDING1       : return DLA_HORSE4_TAIL_BARDING1;
        case DLA_HORSE4_APPEARANCE_BARDING2       : return DLA_HORSE4_TAIL_BARDING2;
        case DLA_HORSE4_APPEARANCE_BARDING3       : return DLA_HORSE4_TAIL_BARDING3;
        case DLA_HORSE4_APPEARANCE_BARDING4       : return DLA_HORSE4_TAIL_BARDING4;
        case DLA_HORSE4_APPEARANCE_BARDING5       : return DLA_HORSE4_TAIL_BARDING5;
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS1 : return DLA_HORSE4_TAIL_BARDING_PACKS1;
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS2 : return DLA_HORSE4_TAIL_BARDING_PACKS2;
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS3 : return DLA_HORSE4_TAIL_BARDING_PACKS3;
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS4 : return DLA_HORSE4_TAIL_BARDING_PACKS4;
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS5 : return DLA_HORSE4_TAIL_BARDING_PACKS5;

        case DLA_HORSE5_APPEARANCE_NIGHTMARE      : return DLA_HORSE5_TAIL_BARDING2;

        case DLA_HORSEJ_APPEARANCE_JOUST1         : return DLA_HORSEJ_TAIL_JOUST1;
        case DLA_HORSEJ_APPEARANCE_JOUST2         : return DLA_HORSEJ_TAIL_JOUST2;
        case DLA_HORSEJ_APPEARANCE_JOUST3         : return DLA_HORSEJ_TAIL_JOUST3;
        case DLA_HORSEJ_APPEARANCE_JOUST4         : return DLA_HORSEJ_TAIL_JOUST4;
        case DLA_HORSEJ_APPEARANCE_JOUST5         : return DLA_HORSEJ_TAIL_JOUST5;
        case DLA_HORSEJ_APPEARANCE_JOUST6         : return DLA_HORSEJ_TAIL_JOUST6;
        case DLA_HORSEJ_APPEARANCE_JOUST7         : return DLA_HORSEJ_TAIL_JOUST7;
        case DLA_HORSEJ_APPEARANCE_JOUST8         : return DLA_HORSEJ_TAIL_JOUST8;
        case DLA_HORSEJ_APPEARANCE_JOUST9         : return DLA_HORSEJ_TAIL_JOUST9;
        case DLA_HORSEJ_APPEARANCE_JOUST10        : return DLA_HORSEJ_TAIL_JOUST10;
        case DLA_HORSEJ_APPEARANCE_JOUST11        : return DLA_HORSEJ_TAIL_JOUST11;
    }
    return APPEARANCE_TYPE_INVALID;
}*/

//Gale Nov 13, 2005
//Return the current number of horse owned by oMaster (including any he is riding)
int DLA_GetNumHorsesOwned(object oMaster)
{
    int iHenchCount, iHenchHorseCount;
    object oHenchman;

    while(GetIsObjectValid(oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster, ++iHenchCount)))
        if(DLA_GetIsDLAHorse(oHenchman) || DLA_GetIsMounted(oHenchman))
            iHenchHorseCount++;

    return iHenchHorseCount + DLA_GetIsMounted(oMaster);
}

//Gale 13 Nov 2005:
//Changed implementation to use newly introduced DLA_GetNumHorsesOwned
//function, and the extra parameter IncMaxHenchIfNeeded, that when set to TRUE,
//make it increase the limit of henchmen (all types, not only horse) by 1
//add the horse henchman, then return the limit to what it was
//Gale 2 Dec 2005: Added new parameter bChangeName
void DLA_SetHenchman(object oHenchman, object oMaster, int bIncMaxHenchIfNeeded = TRUE, int bChangeName=DLA_CHANGE_HORSE_NAME_WHEN_OWNED)
{
    //Gale: 11 June 2006:
    //This is used only to don't have the extra horses from party
    //spelled when a game is loaded. The max number of henchman on party
    //is controled by DLA_MAX_NPC_HENCHMEN constant on dla_i0_switches
    SetMaxHenchmen(10);

    if (!DLA_GetIsDLAHorse(oHenchman))
    {
        object oHenchHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oHenchman);
        if (GetIsObjectValid(oHenchHench))
        {
           RemoveHenchman(oHenchman, oHenchHench);
           DelayCommand(0.1, AddHenchman(oHenchman, oHenchHench));
        }
        if(bIncMaxHenchIfNeeded)
        {
            int nMaxHenchmen = GetMaxHenchmen();
            SetMaxHenchmen(nMaxHenchmen + DLA_GetNumHorsesOwned(oMaster));
            AddHenchman(oMaster, oHenchman);
            SetMaxHenchmen(nMaxHenchmen);
        }
        else
            AddHenchman(oMaster, oHenchman);
        return;

    }

    //Dirge 13/06/05
    //we only want to allow this number of horse henchmen (constant)... if we
    //don't have that many henchman horses yet, then we're okay.
    if(DLA_GetNumHorsesOwned(oMaster) < DLA_MAX_HORSEHENCH_NUMBER)
    {
        //increases maximum henchman number if need be, adds oHenchman as a henchman
        //to oMaster, then resets the max if need be.
        if(bIncMaxHenchIfNeeded)
        {

           // Gale 14 Nov 2005 - Fix on implementation,
           // was seting maxhench -1 henchmans

           // Gale 3 Dec 2005 - Fix to allow horse henchman count to be
           // really separated from normal henchman count
            int iMaxHench = GetMaxHenchmen();
            SetMaxHenchmen( iMaxHench + DLA_GetNumHorsesOwned(oMaster) + 1 );
            AddHenchman(oMaster, oHenchman);
            SetMaxHenchmen( iMaxHench );
            SetAssociateState(NW_ASC_DISTANCE_6_METERS, TRUE, oHenchman);
        }
        else
        {
            AddHenchman(oMaster, oHenchman);
        }

        if (GetMaster(oHenchman) == oMaster)
        {
             SetLocalObject(oHenchman, "oDLA_HORSE_OWNER", oMaster);
             int iDistance;
             switch (DLA_MOUNT_FOLLOW_DISTANCE)
             {
                  case 2: iDistance = NW_ASC_DISTANCE_2_METERS; break;
                  case 4: iDistance = NW_ASC_DISTANCE_4_METERS; break;
                  case 6: iDistance = NW_ASC_DISTANCE_6_METERS; break;
                  default: iDistance = NW_ASC_DISTANCE_6_METERS; break;
             }
             SetAssociateState(iDistance, TRUE, oHenchman);

             if (bChangeName)
                 DLA_IncludeOwnerOnCreatureName(oMaster, oHenchman);
        }

            //Gale 2 Dec 2005 - Change the name of the horse to follow the pattern
            //(Player first name)'s (original name of the horse)

    }
    else
    {
        SendMessageToPC(oMaster, "You may not have more than " + IntToString(DLA_MAX_HORSEHENCH_NUMBER) + " horses as henchman at one time.");
    }
}

//Gale Dec 10, 2005
void DLA_IncludeOwnerOnCreatureName(object oOwner, object oCreature)
{
        string sName = GetName(oOwner);
        SetName(oCreature); //revert to original name
        SetName(oCreature,
            GetSubString(sName, 0 , FindSubString(sName, " " )) + //Get first name of the player
                "'s " + GetName(oCreature));
}

//Gale 4 Dec 2005
//Remove oHenchman as a henchman from oMaster
//Optionally, resets its name
void DLA_RemoveHenchman(object oMaster, object oHenchman=OBJECT_SELF, int bResetName = TRUE, int bSetAsFormerMaster = FALSE)
{
    if (bResetName)
        SetName(oHenchman);

    object oChecking = oMaster;

    int i;
    while (GetIsObjectValid(oChecking))
    {
       if (DLA_GetIsMounted(oChecking) && oHenchman == GetLocalObject(oChecking, "oDLA_HORSE_OWNER"))
           DLA_Dismount(oChecking);
       oChecking = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster,++i);
    }

    if (bSetAsFormerMaster)
       FireHenchman(oMaster, oHenchman);
    else
    {
       SetActionMode(oHenchman, ACTION_MODE_STEALTH, FALSE);
       AssignCommand(oHenchman, ClearAllActions());
       RemoveHenchman(oMaster, oHenchman);
    }

}

int DLA_GetIsDLAHorse(object oCreature)
{
    //return TRUE if this creature has a DLA horse appearance of the kind that
    //we are using when the horse is a henchman
    int nApp=GetAppearanceType(oCreature);

    switch(nApp)
    {
        case DLA_HORSE1_APPEARANCE_BAREBACK:
        case DLA_HORSE1_APPEARANCE_SADDLE:
        case DLA_HORSE1_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE1_APPEARANCE_BARDING1:
        case DLA_HORSE1_APPEARANCE_BARDING2:
        case DLA_HORSE1_APPEARANCE_BARDING3:
        case DLA_HORSE1_APPEARANCE_BARDING4:
        case DLA_HORSE1_APPEARANCE_BARDING5:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS5:

        case DLA_HORSE2_APPEARANCE_BAREBACK:
        case DLA_HORSE2_APPEARANCE_SADDLE:
        case DLA_HORSE2_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE2_APPEARANCE_BARDING1:
        case DLA_HORSE2_APPEARANCE_BARDING2:
        case DLA_HORSE2_APPEARANCE_BARDING3:
        case DLA_HORSE2_APPEARANCE_BARDING4:
        case DLA_HORSE2_APPEARANCE_BARDING5:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS5:

        case DLA_HORSE3_APPEARANCE_BAREBACK:
        case DLA_HORSE3_APPEARANCE_SADDLE:
        case DLA_HORSE3_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE3_APPEARANCE_BARDING1:
        case DLA_HORSE3_APPEARANCE_BARDING2:
        case DLA_HORSE3_APPEARANCE_BARDING3:
        case DLA_HORSE3_APPEARANCE_BARDING4:
        case DLA_HORSE3_APPEARANCE_BARDING5:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS5:

        case DLA_HORSE4_APPEARANCE_BAREBACK:
        case DLA_HORSE4_APPEARANCE_SADDLE:
        case DLA_HORSE4_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE4_APPEARANCE_BARDING1:
        case DLA_HORSE4_APPEARANCE_BARDING2:
        case DLA_HORSE4_APPEARANCE_BARDING3:
        case DLA_HORSE4_APPEARANCE_BARDING4:
        case DLA_HORSE4_APPEARANCE_BARDING5:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS5:

        case DLA_HORSE5_APPEARANCE_NIGHTMARE:

        case DLA_HORSEJ_APPEARANCE_JOUST1:
        case DLA_HORSEJ_APPEARANCE_JOUST2:
        case DLA_HORSEJ_APPEARANCE_JOUST3:
        case DLA_HORSEJ_APPEARANCE_JOUST4:
        case DLA_HORSEJ_APPEARANCE_JOUST5:
        case DLA_HORSEJ_APPEARANCE_JOUST6:
        case DLA_HORSEJ_APPEARANCE_JOUST7:
        case DLA_HORSEJ_APPEARANCE_JOUST8:
        case DLA_HORSEJ_APPEARANCE_JOUST9:
        case DLA_HORSEJ_APPEARANCE_JOUST10:
        case DLA_HORSEJ_APPEARANCE_JOUST11: return TRUE;
    }
    if (nApp>559&&nApp<567) return TRUE;
    return FALSE;
}

void DLA_TakeGoldFromHorseBought(object oPC, int iHorseVar)
{
    int nPrice = DLA_GetHorsePrice(iHorseVar);
    TakeGoldFromCreature(nPrice, oPC, TRUE);
}

int DLA_GetHorsePrice(int iHorseVar)
{
    int iPrice;

    switch(iHorseVar)
    {
        //light horses
        case DLA_TEMPLATE_LIGHT_HORSE_1:    iPrice = DLA_PRICE_LIGHT_HORSE_1;    break;
        case DLA_TEMPLATE_LIGHT_HORSE_2:    iPrice = DLA_PRICE_LIGHT_HORSE_2;    break;
        case DLA_TEMPLATE_LIGHT_HORSE_3:    iPrice = DLA_PRICE_LIGHT_HORSE_3;    break;
        //heavy horses
        case DLA_TEMPLATE_HEAVY_HORSE_1:    iPrice = DLA_PRICE_HEAVY_HORSE_1;    break;
        case DLA_TEMPLATE_HEAVY_HORSE_2:    iPrice = DLA_PRICE_HEAVY_HORSE_2;    break;
        case DLA_TEMPLATE_HEAVY_HORSE_3:    iPrice = DLA_PRICE_HEAVY_HORSE_3;    break;
        //light war horses
        case DLA_TEMPLATE_LIGHT_WARHORSE_1: iPrice = DLA_PRICE_LIGHT_WARHORSE_1; break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_2: iPrice = DLA_PRICE_LIGHT_WARHORSE_2; break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_3: iPrice = DLA_PRICE_LIGHT_WARHORSE_3; break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_4: iPrice = DLA_PRICE_LIGHT_WARHORSE_4; break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_5: iPrice = DLA_PRICE_LIGHT_WARHORSE_5; break;
        //heavy war horses
        case DLA_TEMPLATE_HEAVY_WARHORSE_1: iPrice = DLA_PRICE_HEAVY_WARHORSE_1; break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_2: iPrice = DLA_PRICE_HEAVY_WARHORSE_2; break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_3: iPrice = DLA_PRICE_HEAVY_WARHORSE_3; break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_4: iPrice = DLA_PRICE_HEAVY_WARHORSE_4; break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_5: iPrice = DLA_PRICE_HEAVY_WARHORSE_5; break;
        default: iPrice = 0; break;
    }
    return iPrice;
}

void DLA_BuyHorse(int iHorseVar, object oPC, int iBarding, int iColor, int nForFree = FALSE)
{
    //Gale 4 Dec 2005: Added iBarding and iColor parameters instead of hardcoding references to localvars

    //declare major variables.
    string sHorseTemplate;
    location lNearNewMaster = GetRandomLocation(GetArea(oPC), oPC, 1.0);
    object oHorse;

    //find the appropriate henchman template.
    switch(iHorseVar)
    {
        //light horses
        case DLA_TEMPLATE_LIGHT_HORSE_1:    sHorseTemplate = "dla_lighthorse";  break;
        case DLA_TEMPLATE_LIGHT_HORSE_2:    sHorseTemplate = "dla_lighthorse2"; break;
        case DLA_TEMPLATE_LIGHT_HORSE_3:    sHorseTemplate = "dla_lighthorse3"; break;
        //heavy horses
        case DLA_TEMPLATE_HEAVY_HORSE_1:    sHorseTemplate = "dla_heavyhorse";  break;
        case DLA_TEMPLATE_HEAVY_HORSE_2:    sHorseTemplate = "dla_heavyhorse2"; break;
        case DLA_TEMPLATE_HEAVY_HORSE_3:    sHorseTemplate = "dla_heavyhorse3"; break;
        //light war horses
        case DLA_TEMPLATE_LIGHT_WARHORSE_1: sHorseTemplate = "dla_lgtwarhorse"; break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_2: sHorseTemplate = "dla_lgtwarhorse2";break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_3: sHorseTemplate = "dla_lgtwarhorse3";break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_4: sHorseTemplate = "dla_lgtwarhorse4";break;
        case DLA_TEMPLATE_LIGHT_WARHORSE_5: sHorseTemplate = "dla_lgtwarhorse5";break;
        //heavy war horses
        case DLA_TEMPLATE_HEAVY_WARHORSE_1: sHorseTemplate = "dla_hvywarhorse"; break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_2: sHorseTemplate = "dla_hvywarhorse2";break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_3: sHorseTemplate = "dla_hvywarhorse3";break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_4: sHorseTemplate = "dla_hvywarhorse4";break;
        case DLA_TEMPLATE_HEAVY_WARHORSE_5: sHorseTemplate = "dla_hvywarhorse5";break;
    }

    //moved monetary check here.
    if(nForFree || DLA_GetHorsePrice(iHorseVar) <= GetGold(oPC))
    {
        //now take the gold if need be.
        //Gale 23 April 2006: Fixing this conditional, was missing "!"
        //so, when it was expected to charge, horses were being given for free, and
        //vice versa.
        if(!nForFree)
            DLA_TakeGoldFromHorseBought(oPC, iHorseVar);

        //create horse
        oHorse = CreateObject(OBJECT_TYPE_CREATURE, sHorseTemplate, lNearNewMaster);

        DLA_SetHorseAppearance(oHorse, oPC, iBarding, iColor);
        DLA_SetHenchman(oHorse,oPC);
        SetLocalObject(oHorse,"oDLA_HORSE_OWNER",oPC);
        AddJournalQuestEntry("Horses",1,GetPCSpeaker(),TRUE);
        //Gale 4 Dec 2005: Added extra parameters needed by SetHorseApp
    }
    else
    {
        //Gale:
        //It's needed to check for player GP again, when actually creating the horse
        //(besides the check made to show the buy option) because this fixes an exploit
        //(message): You do not have enough money to purchase this horse.
        SendMessageToPCByStrRef(oPC, 16797873);
    }
}

void DLA_RefreshMovementSpeed(object oCreature)
{
    //Dirge 17/06/05: Now also setting henchman creatures to increased speed
    if(DLA_GetIsMounted(oCreature)
        || (DLA_GetIsDLAHorse(oCreature) && GetIsObjectValid(GetMaster(oCreature))))
    {
        DLA_IncreaseMovementSpeed(oCreature);
    }
    else
    {
        DLA_OriginalMovementSpeed(oCreature);
    }
}

int DLA_GetHasPacks(object oHorse)
{
    //Dirge 17/06/05: Updating for expanded horses textures.
    switch(GetAppearanceType(oHorse))
    {
        case DLA_HORSE1_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS5:

        case DLA_HORSE2_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS5:

        case DLA_HORSE3_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS5:

        case DLA_HORSE4_APPEARANCE_SADDLE_PACKS:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS5: return TRUE;
        default: break;
    }

    switch (GetCreatureTailType(oHorse))
    {
        case DLA_HORSE1_TAIL_SADDLE_PACKS:  // Saddle + Packs
        case DLA_HORSE1_TAIL_BARDING_PACKS1: // leather/cloth Barding/Packs
        case DLA_HORSE1_TAIL_BARDING_PACKS2: // plate/scale Barding/Packs
        case DLA_HORSE1_TAIL_BARDING_PACKS3: // chain/plate Barding/Packs
        case DLA_HORSE1_TAIL_BARDING_PACKS4: // cloth/leather Barding/Packs
        case DLA_HORSE1_TAIL_BARDING_PACKS5: // plate/cloth Barding/Packs
        case DLA_HORSE2_TAIL_SADDLE_PACKS:  // Saddle + Packs
        case DLA_HORSE2_TAIL_BARDING_PACKS1: // leather/cloth Barding/Packs
        case DLA_HORSE2_TAIL_BARDING_PACKS2: // plate/scale Barding/Packs
        case DLA_HORSE2_TAIL_BARDING_PACKS3: // chain/plate Barding/Packs
        case DLA_HORSE2_TAIL_BARDING_PACKS4: // cloth/leather Barding/Packs
        case DLA_HORSE2_TAIL_BARDING_PACKS5: // plate/cloth Barding/Packs
        case DLA_HORSE3_TAIL_SADDLE_PACKS:  // Saddle + Packs
        case DLA_HORSE3_TAIL_BARDING_PACKS1: // leather/cloth Barding/Packs
        case DLA_HORSE3_TAIL_BARDING_PACKS2: // plate/scale Barding/Packs
        case DLA_HORSE3_TAIL_BARDING_PACKS3: // chain/plate Barding/Packs
        case DLA_HORSE3_TAIL_BARDING_PACKS4: // cloth/leather Barding/Packs
        case DLA_HORSE3_TAIL_BARDING_PACKS5: // plate/cloth Barding/Packs
        case DLA_HORSE4_TAIL_SADDLE_PACKS:  // Saddle + Packs
        case DLA_HORSE4_TAIL_BARDING_PACKS1: // leather/cloth Barding/Packs
        case DLA_HORSE4_TAIL_BARDING_PACKS2: // plate/scale Barding/Packs
        case DLA_HORSE4_TAIL_BARDING_PACKS3: // chain/plate Barding/Packs
        case DLA_HORSE4_TAIL_BARDING_PACKS4: // cloth/leather Barding/Packs
        case DLA_HORSE4_TAIL_BARDING_PACKS5: // plate/cloth Barding/Packs
                                            return TRUE;
        default: break;
    }

    return FALSE;
}

int DLA_GetIsInteriorAllowed(object oArea)
{
    //set up to check an area to see if it is NOT interior/underground, or if it
    //is, does it have a variable set on it indicating that horses can enter anyway
    if(!GetIsAreaInterior(oArea) || GetLocalInt(oArea, "iHorseCanEnter") == TRUE)
    {
        return TRUE;
    }
    return FALSE;
}

void DLA_SetHorseAppearance(object oHorse, object oPC, int iBarding, int iColor)
{
    //Gale 4 Dec 2005: Added iBarding and iColor parameters instead of hardcoding references to localvars
    int iAppearanceCurrent = GetAppearanceType(oHorse);
    int iAppearanceNew = iAppearanceCurrent;
    int bPacks = DLA_GetHasPacks(oHorse);
    //Vulcano 9 May 2006:  if we have packs and barding, increment barding by 5
    if (bPacks && iBarding)
    {
      iBarding += 5;
    }
    //Vulcano 9 May 2006: If packs and no barding, use new case 11 appearance
    if(bPacks && !iBarding)
    {
        iBarding = 11;
    }

    if(iColor == DLA_HORSE_COLOR_GUNPOWDER) //gunpowder
    {
        //if we don't have to work with barding changes... then we can simply
        //make a change by adding what is needed to get to the proper texture's
        //equivalent appearance option. Currently the number increment to add
        //is 13
        if(iBarding == DLA_HORSE_BARDING_TYPE_NONE)
        {
            iAppearanceNew = iAppearanceNew + 13;
        }
        //otherwise, we have to specify exactly which barding we want on which
        //texture of horse
        else
        {
            switch(iBarding)
            {
                //barding section
                case 1:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING1; break;
                case 2:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING2; break;
                case 3:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING3; break;
                case 4:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING4; break;
                case 5:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING5; break;
                //barding/packs section
                case 6:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING_PACKS1; break;
                case 7:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING_PACKS2; break;
                case 8:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING_PACKS3; break;
                case 9:  iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING_PACKS4; break;
                case 10: iAppearanceNew = DLA_HORSE2_APPEARANCE_BARDING_PACKS5; break;
                //Vulcano 9 May 2006: saddle/pack only
                case 11: iAppearanceNew = DLA_HORSE2_APPEARANCE_SADDLE_PACKS; break;
            }
        }
    }
    else if(iColor == DLA_HORSE_COLOR_SPOTTED) //spotted
    {
        if(iBarding == 0)
        {
            iAppearanceNew = iAppearanceNew + 26;
        }
        else
        {
            switch(iBarding)
            {
                //barding section
                case 1:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING1; break;
                case 2:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING2; break;
                case 3:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING3; break;
                case 4:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING4; break;
                case 5:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING5; break;
                //barding/packs section
                case 6:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING_PACKS1; break;
                case 7:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING_PACKS2; break;
                case 8:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING_PACKS3; break;
                case 9:  iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING_PACKS4; break;
                case 10: iAppearanceNew = DLA_HORSE3_APPEARANCE_BARDING_PACKS5; break;
                //Vulcano 9 May 2006: saddle/pack only
                case 11: iAppearanceNew = DLA_HORSE3_APPEARANCE_SADDLE_PACKS; break;
            }
        }
    }
    else if(iColor == DLA_HORSE_COLOR_NIGHTMARE) //nightmare
    {
        if(iBarding == 0)
        {
            iAppearanceNew = iAppearanceNew + 39;
        }
        else
        {
            switch(iBarding)
            {
                //barding section
                case 1:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING1; break;
                case 2:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING2; break;
                case 3:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING3; break;
                case 4:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING4; break;
                case 5:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING5; break;
                //barding/packs section
                case 6:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING_PACKS1; break;
                case 7:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING_PACKS2; break;
                case 8:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING_PACKS3; break;
                case 9:  iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING_PACKS4; break;
                case 10: iAppearanceNew = DLA_HORSE4_APPEARANCE_BARDING_PACKS5; break;
                //Vulcano 9 May 2006: saddle/pack only
                case 11: iAppearanceNew = DLA_HORSE4_APPEARANCE_SADDLE_PACKS; break;
            }
        }
    }
    else if(iBarding != 0) //walnut...only work with barding
    {
        switch(iBarding)
        {
            //barding section
            case 1:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING1; break;
            case 2:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING2; break;
            case 3:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING3; break;
            case 4:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING4; break;
            case 5:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING5; break;
            //barding/packs section
            case 6:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING_PACKS1; break;
            case 7:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING_PACKS2; break;
            case 8:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING_PACKS3; break;
            case 9:  iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING_PACKS4; break;
            case 10: iAppearanceNew = DLA_HORSE1_APPEARANCE_BARDING_PACKS5; break;
            //Vulcano 9 May 2006: saddle/pack only
            case 11: iAppearanceNew = DLA_HORSE1_APPEARANCE_SADDLE_PACKS; break;
        }
    }

    //if appearance needs to change, change it
    if(iAppearanceNew != iAppearanceCurrent)
    {
        SetCreatureAppearanceType(oHorse, iAppearanceNew);
    }

    DLA_SetHorsePortrait(oHorse);
}

void DLA_SetHorsePortrait(object oHorse)
{
    int iIdPortrait;

    switch(GetAppearanceType(oHorse))
    {
        case DLA_HORSE1_APPEARANCE_BAREBACK: iIdPortrait = PORTRAIT_DLA_WALNUT_BAREBACK; break;
        case DLA_HORSE1_APPEARANCE_SADDLE: iIdPortrait = PORTRAIT_DLA_WALNUT_NOBARDING; break;
        case DLA_HORSE1_APPEARANCE_SADDLE_PACKS: iIdPortrait = PORTRAIT_DLA_WALNUT_NOBARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING1: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING2: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING3: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING4: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING5: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS1: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS2: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS3: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS4: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;
        case DLA_HORSE1_APPEARANCE_BARDING_PACKS5: iIdPortrait = PORTRAIT_DLA_WALNUT_BARDING; break;

        case DLA_HORSE2_APPEARANCE_BAREBACK: iIdPortrait = PORTRAIT_DLA_GUNPOWDER_BAREBACK; break;
        case DLA_HORSE2_APPEARANCE_SADDLE:
        case DLA_HORSE2_APPEARANCE_SADDLE_PACKS: iIdPortrait = PORTRAIT_DLA_GUNPOWDER_NOBARDING; break;
        case DLA_HORSE2_APPEARANCE_BARDING1:
        case DLA_HORSE2_APPEARANCE_BARDING2:
        case DLA_HORSE2_APPEARANCE_BARDING3:
        case DLA_HORSE2_APPEARANCE_BARDING4:
        case DLA_HORSE2_APPEARANCE_BARDING5:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE2_APPEARANCE_BARDING_PACKS5: iIdPortrait = PORTRAIT_DLA_GUNPOWDER_BARDING; break;

        case DLA_HORSE3_APPEARANCE_BAREBACK: iIdPortrait = PORTRAIT_DLA_SPOTTED_BAREBACK; break;
        case DLA_HORSE3_APPEARANCE_SADDLE:
        case DLA_HORSE3_APPEARANCE_SADDLE_PACKS: iIdPortrait = PORTRAIT_DLA_SPOTTED_NOBARDING; break;
        case DLA_HORSE3_APPEARANCE_BARDING1:
        case DLA_HORSE3_APPEARANCE_BARDING2:
        case DLA_HORSE3_APPEARANCE_BARDING3:
        case DLA_HORSE3_APPEARANCE_BARDING4:
        case DLA_HORSE3_APPEARANCE_BARDING5:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE3_APPEARANCE_BARDING_PACKS5: iIdPortrait = PORTRAIT_DLA_SPOTTED_BARDING; break;

        case DLA_HORSE4_APPEARANCE_BAREBACK: iIdPortrait = PORTRAIT_DLA_NIGHTMARE_BAREBACK; break;
        case DLA_HORSE4_APPEARANCE_SADDLE:
        case DLA_HORSE4_APPEARANCE_SADDLE_PACKS: iIdPortrait = PORTRAIT_DLA_NIGHTMARE_NOBARDING; break;
        case DLA_HORSE4_APPEARANCE_BARDING1:
        case DLA_HORSE4_APPEARANCE_BARDING2:
        case DLA_HORSE4_APPEARANCE_BARDING3:
        case DLA_HORSE4_APPEARANCE_BARDING4:
        case DLA_HORSE4_APPEARANCE_BARDING5:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS1:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS2:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS3:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS4:
        case DLA_HORSE4_APPEARANCE_BARDING_PACKS5: iIdPortrait = PORTRAIT_DLA_NIGHTMARE_BARDING; break;
        default : iIdPortrait = PORTRAIT_INVALID; break;
      }
      if (iIdPortrait != PORTRAIT_INVALID)
         SetPortraitId(oHorse, iIdPortrait);

}

//Gale Nov 28, 2005
//Force OBJECT_SELF to REALLY unequip oItem
//Note: ClearAllActions is used inside of this function
void DLA_ForceUnequip(object oItem)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), OBJECT_SELF, 0.1);
    ClearAllActions(TRUE);
    ActionUnequipItem(oItem);
    ActionDoCommand(SetCommandable(TRUE));
    SetCommandable(FALSE);
}

//Gale 14 Nov, 2005: Function moved back to dla_i0_horse, to avoid circular dependency
void DLA_UnequipShield(object oPC, object oItem=OBJECT_INVALID)
{

    if (oItem == OBJECT_INVALID)
           oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

    if (GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD || GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD || GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD)
    {
        SetLocalObject(oPC,"oMountedShield",oItem);
        FloatingTextStringOnCreature("You cannot equip a shield while riding.", oPC, FALSE);
        AssignCommand(oPC, DLA_ForceUnequip(oItem));
    }

}

//Gale 14 Nov, 2005: Function moved back to dla_i0_horse, to avoid circular dependency
void DLA_UnequipForbiddenWeapon(object oPC, object oItem=OBJECT_INVALID)
{
    if (oItem == OBJECT_INVALID)
           oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);

    int BaseItemType = GetBaseItemType(oItem);

    if (BaseItemType == BASE_ITEM_DOUBLEAXE || BaseItemType == BASE_ITEM_TWOBLADEDSWORD)
    {
        FloatingTextStringOnCreature("You cannot use this weapon while riding.", oPC, FALSE);
        AssignCommand(oPC, DLA_ForceUnequip(oItem));
    }
}

//Gale 23 Nov, 2005
//Get the horse henchman belonging to oMaster
// Return OBJECT_INVALID if oMaster don't have nNth horse henchmen.
// nNth: wich henchman to return
// OBS: THIS FUNCTION DON'T ALLOW ACCESS TO HORSES CURRENTLY BEING MOUNTED
// Deva   6/28/2006 - Changed to GetAssociate more reliable than GetHenchman
object DLA_GetHorseHenchman(object oMaster, int nNth=1)
{
   int nHorseHenchNum;
   object oHenchman;
   int nN=1;

   oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster,nN);
   while(GetIsObjectValid(oHenchman))
   { // valid henchman
       if (DLA_GetIsDLAHorse(oHenchman))
       { // it is a horse
           nHorseHenchNum++;
           if (nHorseHenchNum==nNth)
           { // horse we want found
               return oHenchman;
           } // horse we want found
       } // it is a horse
       nN++;
       oHenchman=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster,nN);
   } // valid henchman

   return OBJECT_INVALID;
}

//Gale 3 Dec 2005
void DLA_RefreshMountedArcheryPenalty()
{
     int iMountedArcheryPenalty = GetLocalInt(OBJECT_SELF, "DLA_MountedArchery");

     if (DLA_GetIsMounted(OBJECT_SELF) && GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF)))
     {
        int nPenalty = 4;
        if (GetHasFeat(FEAT_DLA_MOUNTED_ARCHERY, OBJECT_SELF))
        {
            // Penalty cut in half with Mounted Archery
            nPenalty = 2;
        }

        if (nPenalty != iMountedArcheryPenalty)
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAttackDecrease(nPenalty)), OBJECT_SELF);
            SetLocalInt(OBJECT_SELF, "DLA_MountedArchery", nPenalty);
        }
     }

     else if (iMountedArcheryPenalty) //if receiving penalty, but not using ranged weapon anymore
     {
        effect ePenalty = GetFirstEffect(OBJECT_SELF);
        while (GetIsEffectValid(ePenalty))
        {
           if ((GetEffectType(ePenalty) == EFFECT_TYPE_ATTACK_DECREASE) &&
           (GetEffectSubType(ePenalty) == SUBTYPE_SUPERNATURAL) &&
           (GetEffectDurationType(ePenalty) == DURATION_TYPE_PERMANENT))
           {
               RemoveEffect(OBJECT_SELF, ePenalty);
               SetLocalInt(OBJECT_SELF, "DLA_MountedArchery", 0);
               return;
           }
           ePenalty = GetNextEffect(OBJECT_SELF);
        }
     }
}

int DLA_GetHasWarHorse(object oCreature)
{
    if (DLA_GetMountIsWarhorse(oCreature)) return TRUE;

    object oHenchman;
    int i=0;
    //Gale 12 Feb 2006: Changed to use functions GetHorseIsWarHorse and GetIsWarhorse
    //Syrsnein 26 Mar 2006: Changed GetHorseIsWarHorse to GetIsWarhorse and GetIsWarhorse
    //  to GetMountIsWarhorse
    while (GetIsObjectValid(oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature,++i)))
    {//oHenchman is valid
        if (DLA_GetIsDLAHorse(oHenchman))
        {//It's a horse
            if (DLA_GetIsWarhorse(oHenchman))
            {//It's a warhorse
                return TRUE;
            }//It's a warhorse
        }//It's a horse
        else if (DLA_GetMountIsWarhorse(oHenchman))
        {//Not a horse, check if it's mounted on a warhorse
            return TRUE;
        }//Not a horse
    }//oHenchman is valid
    return FALSE;
}

int DLA_GetIsWarhorse(object oCreature)
{
    string sResRef = GetResRef( oCreature );

    // If the resref is any of the listed, then it's a warhorse, then return true. if not, returns false

    return
       (sResRef == "dla_lgtwarhorse5" || sResRef == "dla_lgtwarhorse"  || sResRef == "dla_lgtwarhorse2" ||
        sResRef == "dla_lgtwarhorse3" || sResRef == "dla_lgtwarhorse4" || sResRef == "dla_hvywarhorse5" ||
        sResRef == "dla_hvywarhorse"  || sResRef == "dla_hvywarhorse2" || sResRef == "dla_hvywarhorse3" ||
        sResRef == "dla_hvywarhorse4" || sResRef == "dla_palhorse1"    || sResRef == "dla_palhorse2"    ||
        sResRef == "dla_palhorse3"    || sResRef == "dla_palhorse4");
}

//Syrsnein - 26 Mar 2006: Replaces DLA_GetIsWarhorse to determine if oPC is mounted
//  on a warhorse.
int DLA_GetMountIsWarhorse(object oPC)
{
    //Gale 28 Nov 2005: Fix to return the correct value

    string sResRef = GetLocalString( oPC, "sDLA_Horse");

    // If the resref is any of the listed, then it's a warhorse, then return true. if not, returns false

    return
       (sResRef == "dla_lgtwarhorse5" || sResRef == "dla_lgtwarhorse"  || sResRef == "dla_lgtwarhorse2" ||
        sResRef == "dla_lgtwarhorse3" || sResRef == "dla_lgtwarhorse4" || sResRef == "dla_hvywarhorse5" ||
        sResRef == "dla_hvywarhorse"  || sResRef == "dla_hvywarhorse2" || sResRef == "dla_hvywarhorse3" ||
        sResRef == "dla_hvywarhorse4" || sResRef == "dla_palhorse1"    || sResRef == "dla_palhorse2"    ||
        sResRef == "dla_palhorse3"    || sResRef == "dla_palhorse4");

}


int DLA_GetHorseIsWarHorse(object oCreature)
{
    string sResRef = GetResRef( oCreature );

    // If the resref is any of the listed, then it's a warhorse, then return true. if not, returns false

    return
       (sResRef == "dla_lgtwarhorse5" || sResRef == "dla_lgtwarhorse"  || sResRef == "dla_lgtwarhorse2" ||
        sResRef == "dla_lgtwarhorse3" || sResRef == "dla_lgtwarhorse4" || sResRef == "dla_hvywarhorse5" ||
        sResRef == "dla_hvywarhorse"  || sResRef == "dla_hvywarhorse2" || sResRef == "dla_hvywarhorse3" ||
        sResRef == "dla_hvywarhorse4" || sResRef == "dla_palhorse1"    || sResRef == "dla_palhorse2"    ||
        sResRef == "dla_palhorse3"    || sResRef == "dla_palhorse4");


}

int DLA_GetHorseOwnerIsAssociateOrPC(object oCreature)
{
   object oHorseOwner = GetLocalObject(oCreature, "oDLA_HORSE_OWNER");
   return (GetIsPC(oHorseOwner) || GetIsPC(GetMaster(oHorseOwner)));
}

object DLA_GetHorseOwner(object oHorse)
{
   return GetLocalObject(oHorse, "oDLA_HORSE_OWNER");
}

/*void DLA_ReturnOwnedHorsesOnAreaToPCParty(object oPC, object oArea=OBJECT_INVALID)
{
    if (!GetIsObjectValid(oArea)) oArea = GetArea(oPC);
    object oCreature = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oCreature))
    {
        if (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE && DLA_GetIsDLAHorse(oCreature))
        {
            object oHorseOwner = GetLocalObject(oCreature, "oDLA_HORSE_OWNER");
            if ((oHorseOwner == oPC) || (GetMaster(oHorseOwner) == oPC))
            {
                DLA_SetHenchman(oCreature, oHorseOwner, TRUE, DLA_CHANGE_HORSE_NAME_WHEN_OWNED);
                // Deva Winblood   May 11, 2006
                if (DLA_GetIsTied(oCreature))
                { // untie properly - to remove any waypoints
                  DLA_UntieHorse(oCreature);
                } // untie properly - to remove any waypoints
                AssignCommand(oCreature, JumpToObject(oHorseOwner));
            }
        }
        oCreature = GetNextObjectInArea(oArea);
    }
}*/


void DLA_ReturnOwnedHorsesOnAreaToPCParty(object oPC,object oArea=OBJECT_INVALID)
{ // PURPOSE: This function was rewritten to use GetNearestCreature which is more
  // efficient in this case than grabbing every object including doors, waypoints,
  // placeables, triggers, items, etc.
  // Scripted By: Deva B. Winblood  7/29/2006

    object oMyArea=oArea;
    object oCenter;
    object oCreature;
    object oHorseOwner;
    int nN=1;
    if (!GetIsObjectValid(oArea)) oMyArea=GetArea(oPC);
    oCenter=GetFirstObjectInArea(oMyArea);
    if (GetObjectType(oCenter)==OBJECT_TYPE_CREATURE) oCenter=GetNearestObject(OBJECT_TYPE_PLACEABLE,oCenter,1);
    oCreature=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oCenter,nN);
    while(GetIsObjectValid(oCreature))
    { // check all creatures
        if (DLA_GetIsDLAHorse(oCreature))
        { // it is a horse
            oHorseOwner=GetLocalObject(oCreature,"oDLA_HORSE_OWNER");
            if (oHorseOwner==oPC||GetMaster(oHorseOwner)==oPC)
            { // valid horse to activate
                SetCommandable(TRUE,oCreature);
                SetAILevel(oCreature,AI_LEVEL_DEFAULT);
                DLA_SetHenchman(oCreature,oHorseOwner,TRUE,DLA_CHANGE_HORSE_NAME_WHEN_OWNED);
                if (DLA_GetIsTied(oCreature))
                { // untie - this clears tied map notes as well
                    DLA_UntieHorse(oCreature);
                } // untie - this clears tied map notes as well
                AssignCommand(oCreature,ClearAllActions(TRUE));
                AssignCommand(oCreature,JumpToObject(oHorseOwner));
                SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oCreature);
            } // valid horse to activate
        } // it is a horse
        nN++;
        oCreature=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oCenter,nN);
    } // check all creatures
    DeleteLocalInt(oPC,"DLA_CANT_MOUNT");
} // DLA_ReturnOwnedHorsesOnAreaToPCParty()


int DLA_CountOwnedHorsesInArea(object oPC,object oArea=OBJECT_INVALID, int nTiedOnly=FALSE)
{ // Counts up the horses in the area owned by the PC
// B G P Hughes 11/08/08

    object oMyArea=oArea;
    object oCenter;
    object oCreature;
    object oHorseOwner;
    int nN=1;
    int nTotal = 0;
    int nSubTotal = 0; //returns tied horses only

    if (!GetIsObjectValid(oArea)) oMyArea=GetArea(oPC);
    oCenter=GetFirstObjectInArea(oMyArea);
    if (GetObjectType(oCenter)==OBJECT_TYPE_CREATURE) oCenter=GetNearestObject(OBJECT_TYPE_PLACEABLE,oCenter,1);
    oCreature=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oCenter,nN);
    while(GetIsObjectValid(oCreature))
    { // check all creatures
        if (DLA_GetIsDLAHorse(oCreature))
        { // it is a horse
            oHorseOwner=GetLocalObject(oCreature,"oDLA_HORSE_OWNER");
            if (oHorseOwner==oPC||GetMaster(oHorseOwner)==oPC)
            { // valid horse to activate
                nTotal++;
                if (DLA_GetIsTied(oCreature))
                { // untie - this clears tied map notes as well
                    nSubTotal++;
                } // untie - this clears tied map notes as well
            } // valid horse to activate
        } // it is a horse
        nN++;
        oCreature=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oCenter,nN);
    } // check all creatures
    if (nTiedOnly == TRUE) nTotal = nSubTotal;
    return nTotal;
}


//Recursive function
//Syrsnein 12 April 2006: modified function to recurse when neccessary.
//Checks for a free warhorse before checking NPCs for being mounted on one.
object DLA_GetWarhorse(object oCreature, int Nth=1, int bPlayAnimation=FALSE)
{
   DLA_HorseDebug("<DLA_GetWarhorse>");
   DLA_HorseDebug("   Looking for warhorse #" + IntToString(Nth) + " in " +
                  GetName(oCreature) + "'s party.");

   int i = 1;
   int nWarhorse = 0;
   int bFound = FALSE;
   int bSkipNPC = TRUE;
   object oHorse = OBJECT_INVALID;
   object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature, i);
   while (!bFound && GetIsObjectValid(oHenchman))
   {
       DLA_HorseDebug("   Looking at index " + IntToString(i) + ": " + GetName(oHenchman) + ".");
       if (DLA_GetIsDLAHorse(oHenchman))
       {// If it's a horse
           DLA_HorseDebug("   " + GetName(oHenchman) + " is a horse.");
           if (DLA_GetIsWarhorse(oHenchman))
           {
               DLA_HorseDebug("   " + GetName(oHenchman) + " is a warhorse.");
               nWarhorse++;
               if (nWarhorse==Nth)
               {
                   oHorse = oHenchman;
                   bFound = TRUE;
               }
           }
       }
       else
       {// It's a henchman, check if they have a warhorse.
           DLA_HorseDebug("   " + GetName(oHenchman) + " is not a horse.");
           if (!bSkipNPC)
           {
               if (DLA_GetIsMounted(oHenchman) && DLA_GetMountIsWarhorse(oHenchman))
               { // They have a warhorse, dismount them.
                   DLA_HorseDebug("   " + GetName(oHenchman) + " is mounted on a warhorse.");
                   DLA_HorseDebug("   Dismounting " + GetName(oHenchman) + ".");
                   DLA_Dismount(oHenchman, bPlayAnimation);
                   oHorse = DLA_GetWarhorse(oCreature, Nth, bPlayAnimation);
               }
           }
       }
       i++;
       oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature, i);
       // do this over again checking henchmen if we haven't got our horse
       if (!GetIsObjectValid(oHenchman) && !bFound && bSkipNPC)
       {
           bSkipNPC = FALSE;
           i=1;
           oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature, i);
       }
   }
   if (!bFound)
   {
       DLA_HorseDebug("   Did not find the warhorse.");
       return OBJECT_INVALID;
   }
   else
   {
       DLA_HorseDebug("   " + GetName(oHorse) + " is the warhorse we want.");
       return oHorse;
   }
}

int DLA_RemovePartyHorsesAndLeaveOnPlace(object oPC)
{
    int bResult = FALSE;
    object oHenchman;
    int i=1;

    if (DLA_GetIsMounted(oPC))
    {
       bResult = TRUE;
       DLA_Dismount(oPC, TRUE, FALSE);
    }

    while (GetIsObjectValid(oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC, i)))
    {
        if (DLA_RemovePartyHorsesAndLeaveOnPlace(oHenchman))
            bResult=TRUE;

        if  (DLA_GetIsDLAHorse(oHenchman)) //is a horse
        {
            DLA_RemoveHenchman(oPC, oHenchman, DLA_RESET_NAME_WHEN_REMOVING_ALL_PARTY_HORSES, TRUE);
            // Set starting location
            AssignCommand(oHenchman, SetAssociateStartLocation());
            AssignCommand(oHenchman, SetRespawnLocation());
            bResult = TRUE;
            continue;
        }
        i++;
    }
    return bResult;
}

void DLA_ReturnLacindasHorse(object oPC, object oLacinda)
{
    object oHench;
    int i;
    object oHorse;

    if (GetLocalInt(oPC, "bLacindasOwnedHorse")&&DLA_GetIsMounted(oPC))
        DLA_Dismount(oPC, TRUE, TRUE, FALSE, oLacinda);
    else
    { //
      while (GetIsObjectValid(oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC, ++i)))
        if (GetLocalInt(oHench, "bLacindasOwnedHorse"))
        {
            if (DLA_GetIsMounted(oHench)) //It's a creature mounting it
                DLA_Dismount(oHench, TRUE, TRUE, FALSE, oLacinda);
            else
            {
                oHorse = oHench; //it's the horse itself
                DLA_SetHenchman(oHorse, oLacinda);
            }
            //break;
         }
     } //
}


void DLA_IntegerToVoid(int nN)
{ // PURPOSE: Captures parameter

    // Do nothing

} // DLA_IntegerToVoid()


int DLA_RemoveAllHenchmenHorses(object oCreature,object oHitchingPost=OBJECT_INVALID,int bAnimation=TRUE)
{ // PURPOSE: Complete rewrite of this function to address problems with it not
  // functioning properly
  // Deva B. Winblood   7/29/2006 - Mantis Bugs #1865, 1947, 1937, 1909
  // Deva B. WInblood   8/03/2006 - Made it call new function which handles this safely
    int nResult=0;
    int bDelay=FALSE;
    object oHench;
    int nID;
    int nN=1;
    vector vHitchingDirection;
    object oHitch=oHitchingPost;

    if (!GetIsObjectValid(oHitch)) oHitch=GetNearestObjectByTag(DLA_TAG_HITCHING_POST);

    DLA_NoHorseTransition(oCreature,OBJECT_INVALID,bAnimation,TRUE,oHitch);

    /*oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature,nN);
    while(GetIsObjectValid(oHench))
    { // check all henchmen
        if (!DLA_GetIsDLAHorse(oHench))
        { // not a horse
            if (DLA_GetIsMounted(oHench))
            { // mounted
                DLA_Dismount(oHench,bAnimation,FALSE,TRUE);
                bDelay=TRUE;
                nResult++;
            } // mounted
        } // not a horse
        else
        { // horse
            SetAILevel(oHench,AI_LEVEL_NORMAL);
            SetCommandable(TRUE,oHench);
            vHitchingDirection = GetPosition(oHitch);
            DLA_RemoveHenchman(oCreature, oHench, DLA_RESET_NAME_WHEN_ON_HITCHING, TRUE);
            AssignCommand(oHench, ClearAllActions(TRUE));
            AssignCommand(oHench, ActionJumpToObject(oHitch));
            AssignCommand(oHench, SetFacingPoint(vHitchingDirection));
            AssignCommand(oHench, SetAssociateStartLocation());
            AssignCommand(oHench, SetRespawnLocation());
            DLA_SetIsTied(oHench);
            nID=GetLocalInt(oHench,"nID");
            if (nID==0)
            { // assign horse unique ID - used to handle removing mapnotes later
                nID=DLA_GetHorseID();
                SetLocalObject(GetModule(),"oHorse_Instance_"+IntToString(nID),oHench);
                SetLocalInt(oHench,"nID",nID);
            } // assign horse unique ID - used to handle removing mapnotes later
            oHitch = CreateObject(OBJECT_TYPE_WAYPOINT, "dla_wp_horset002", GetLocation(oHitch));
            SetLocalObject(oHench, "dla_hitch", oHitch);
            SetLocalObject(GetModule(),"oTied_Horse_Mapnote_"+IntToString(nID),oHitch);
            nResult++;
            bDelay=TRUE;
        } // horse
        nN++;
        oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature,nN);
    } // check all henchmen
    if (DLA_GetIsMounted(oCreature))
    { // deal with self
        DLA_Dismount(oCreature,bAnimation,FALSE,TRUE);
        bDelay=TRUE;
        nResult++;
    } // deal with self
    if (bDelay) DelayCommand(4.0,DLA_IntegerToVoid(DLA_RemoveAllHenchmenHorses(oCreature,oHitchingPost,bAnimation)));
    */
    return (nResult > 0);
} // DLA_RemoveAllHenchmenHorses()


/*//Removes all horse being mounted by any of oCreature's henchmen
//Return TRUE if remove at least one horse, and FALSE otherwise.
int DLA_RemoveAllHenchmenHorses(object oCreature, object oHitchingPost=OBJECT_INVALID, int bAnimation=TRUE)
{
    int bResult = 0;
    object oHenchman;
    int nID; // Deva Winblood   May 11, 2006
    int i=1;
    vector vHitching;  // moved declaration to namespace 7/29/2006  Deva Winblood
    object oHitch;
    if (!GetIsObjectValid(oHitchingPost))
        oHitchingPost = GetNearestObjectByTag(DLA_TAG_HITCHING_POST);

    oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature, i);
    while (GetIsObjectValid(oHenchman))
    {
//        if (DLA_RemoveAllHenchmenHorses(oHenchman, oHitchingPost))
//            bResult=TRUE;
        if (!DLA_GetIsDLAHorse(oHenchman))
        {// This is not a horse
            if (DLA_GetIsMounted(oHenchman))
            {
                DLA_Dismount(oHenchman, bAnimation,FALSE,TRUE);
//                bResult = TRUE;
            }
            bResult += DLA_RemoveAllHenchmenHorses(oHenchman, oHitchingPost);
        }
        else
        {// This is a horse
            vHitching = GetPosition(oHitchingPost);
            DLA_RemoveHenchman(oCreature, oHenchman, DLA_RESET_NAME_WHEN_ON_HITCHING, TRUE);
            AssignCommand(oHenchman, ClearAllActions());
            AssignCommand(oHenchman, ActionJumpToObject(oHitchingPost));
            AssignCommand(oHenchman, SetFacingPoint(vHitching));
            // Set starting location
            AssignCommand(oHenchman, SetAssociateStartLocation());
            AssignCommand(oHenchman, SetRespawnLocation());
            DLA_SetIsTied(oHenchman);
            nID=GetLocalInt(oHenchman,"nID"); // Deva Winblood   May 11, 2006
            if (nID==0)
            { // assign horse unique ID - used to handle removing mapnotes later
                nID=DLA_GetHorseID();
                SetLocalObject(GetModule(),"oHorse_Instance_"+IntToString(nID),oHenchman);
                SetLocalInt(oHenchman,"nID",nID);
            } // assign horse unique ID - used to handle removing mapnotes later
            oHitch = CreateObject(OBJECT_TYPE_WAYPOINT, "dla_wp_horset002", GetLocation(oHitchingPost));
            SetLocalObject(oHenchman, "dla_hitch", oHitch);
            // Deva Winblood   May 11, 2006
            SetLocalObject(GetModule(),"oTied_Horse_Mapnote_"+IntToString(nID),oHitch);
            bResult++;
//            continue;
        }
        i++;
        oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oCreature, i);
    }
    return (bResult > 0);
}
*/

/*int DLA_GetIsPaladinMount(object oHenchman)
{
  return GetStringLeft(GetResRef(oHenchman), 12) == "dla_palhorse";
}   */

int DLA_GetHasPaladinMount (object oPlayer)
{
  int i;
  object oHenchman;
  while (GetIsObjectValid(oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPlayer,++i)))
     if (DLA_GetIsPaladinMount(oHenchman)) return TRUE;
  return FALSE;
}


void DLA_Horse_FinalizeMounted(object oCreature,object oHorse)
{
  effect eDisarmTrap = SupernaturalEffect(EffectSkillDecrease(SKILL_DISABLE_TRAP , 50));
  effect eOpenLock   = SupernaturalEffect(EffectSkillDecrease(SKILL_OPEN_LOCK    , 50));
  effect eHide       = SupernaturalEffect(EffectSkillDecrease(SKILL_HIDE         , 50));
  effect eMove       = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY, 50));
  effect ePickPocket = SupernaturalEffect(EffectSkillDecrease(SKILL_PICK_POCKET  , 50));
  effect eSetTrap    = SupernaturalEffect(EffectSkillDecrease(SKILL_SET_TRAP     , 50));
  effect eTumble     = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE       , 50));

  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisarmTrap, oCreature);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eOpenLock, oCreature);
  SetFootstepType(FOOTSTEP_TYPE_DLA_HORSE, oCreature);
  DLA_DestroyHorseHenchman(oCreature, oHorse);

  // 6/15/2006 - Deva B. Winblood - Added to fix sunken horse
  if (!DLA_GetIsMounted(oCreature))
  { // player is still not in proper phenotype
    DLA_ChangeToMountedAppearance(oCreature);
  } // player is still not in proper phenotype

  DLA_HorseDebug("   Done mounting.["+GetName(oCreature)+"]");
  DeleteLocalInt(oCreature,"nDLAMountState");
} // DLA_Horse_FinalizeMounted()


void DLA_Horse_AnimateMounting(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail)
{
  //effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
  DLA_HorseDebug("   Playing mounting animation.["+GetName(oCreature)+"]");
  // June 22, 2006 - Deva Winblood - Removed invis so, this horse can be used
  // instead of using the proxy.  Should eliminate a lot of the blinking (#1720)
  //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oHorse,6.0);
  DLA_MountSequence(oCreature,nHorseTail,oHorse);
  if (!bCutsceneMode)
        AssignCommand(oCreature,DelayCommand(3.7,SetCutsceneMode(oCreature,FALSE)));
  AssignCommand(oCreature,ActionDoCommand(DLA_Horse_FinalizeMounted(oCreature,oHorse)));
  SetLocalInt(oCreature,"nDLAMountState",3);
} // DLA_HorseAnimateMounting()


void DLA_Horse_PreserveMountInfo(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail)
{
  int nID=GetLocalInt(oHorse,"nID");

  SetLocalString(oCreature,"sDLA_Horse",GetResRef(oHorse));
  SetLocalInt(oCreature,"iDLA_Horse_App",GetAppearanceType(oHorse));
  SetLocalInt(oCreature,"iDLA_HorseHP",GetCurrentHitPoints(oHorse));
  SetLocalObject(oCreature,"oDLA_HORSE_OWNER",GetLocalObject(oHorse,"oDLA_HORSE_OWNER"));
  SetLocalObject(oCreature,"oDLAHorseAssigned",GetLocalObject(oHorse,"oAssigned"));

  if (DLA_GetIsPaladinMount(oHorse))
        SetLocalInt(oCreature,"nPalHorseDespawnTime",GetLocalInt(oHorse,"nDespawnHour"));

  SetLocalInt(oCreature,"nHorseID",nID);

  if (GetLocalInt(oHorse,"bLacindasOwnedHorse"))
        SetLocalInt(oCreature,"bLacindasOwnedHorse",TRUE);

  DLA_HorseDebug("   Local variables set:["+GetName(oCreature)+"]");
  DLA_HorseDebug("      sDLA_Horse        = " + GetLocalString(oCreature, "sDLA_Horse") + ".");
  DLA_HorseDebug("      iDLA_Horse_App    = " + IntToString(GetLocalInt(oCreature, "iDLA_Horse_App")) + ".");
  DLA_HorseDebug("      iDLA_HorseHP:     = " + IntToString(GetLocalInt(oCreature, "iDLA_HorseHP")) + ".");
  DLA_HorseDebug("      oDLAHorseAssigned = " + GetName(GetLocalObject(oCreature,"oDLAHorseAssigned")));

  SetLocalString(oCreature,"sHorseTag",GetTag(oHorse));

  if (GetFirstItemInInventory(oHorse)!=OBJECT_INVALID)
  { // preserve contents of horses inventory
    DLA_HorseDebug("       Horse has packs..["+GetName(oCreature)+"]");
    DelayCommand(0.1, DLA_Horse_TransferEquipment(oHorse,oCreature));
  } // preserve contents of horses inventory
  else
  { // no packs
    // Deva 5/24/2006 - we do not want to destroy the horse until Mounting Finalized
    //DLA_HorseDebug("   DLA_DestroyHorseHenchman("+GetName(oCreature)+","+GetName(oHorse)+") DLA_Horse_PreserveMountInfo()");
    //DelayCommand(0.2, DLA_DestroyHorseHenchman(oCreature, oHorse));
  } // no packs

  if (bPlayAnimation)
  { // animate mounting
    DelayCommand(0.3, AssignCommand(oCreature, ActionDoCommand(
             DLA_Horse_AnimateMounting(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail))));
  } // animate mounting
  else
  { // no animation required
    DLA_HorseDebug("   Skipping mounting animation.["+GetName(oCreature)+"]");
    DLA_ChangeToMountedAppearance(oCreature);
    DLA_AddHorseTail(oCreature, nHorseTail);
    DLA_RefreshMovementSpeed(oCreature);
    DelayCommand(0.3,AssignCommand(oCreature,ActionDoCommand(DLA_Horse_FinalizeMounted(oCreature,oHorse))));
  } // no animation required

  SetLocalInt(oCreature,"nDLAMountState",2);
} // DLA_Horse_PreserveMountInfo()



void DLA_Horse_PrepMountAnimation(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail)
{

  effect eGhost = EffectCutsceneGhost();
  location lDestination = GetStepLeftLocation(oHorse);
  //effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

  DLA_HorseDebug("   Setting up mount animation.["+GetName(oCreature)+","+GetName(oHorse)+"]");

  // lock horse in place
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oHorse,6.0);
  // Deva Winblood 5/24/2006 - clear out any ActionForceFollow stuff
  if (!GetIsPC(oCreature)) AssignCommand(oCreature,ClearAllActions(TRUE));
  // modified 6/22/2006 - Deva Winblood - To remove some animation oddities that can occur
  if (GetDistanceBetweenLocations(GetLocation(oCreature),lDestination)>3.0)
  { // move
      AssignCommand(oCreature, ActionForceMoveToLocation(lDestination, TRUE, 3.0));
  } // move
  else
  { // move away a bit
      AssignCommand(oCreature, ActionMoveAwayFromObject(oHorse,TRUE,1.0));
      AssignCommand(oCreature, ActionForceMoveToLocation(lDestination, TRUE, 3.0));
  } // move away a bit
  AssignCommand(oCreature, ActionDoCommand(SetFacing(GetFacingFromLocation(lDestination))));
  //AssignCommand(oCreature, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oHorse,8.0)));
  //AssignCommand(oCreature, RemoveSpecificEffect(EFFECT_TYPE_CUTSCENEGHOST, oCreature));

  DLA_HorseDebug("   Ready to do mount animation.["+GetName(oCreature)+"]");

  AssignCommand(oCreature,ActionDoCommand(SetLocalInt(oCreature,"nDLAMountState",1)));
  AssignCommand(oCreature, ActionDoCommand(DLA_Horse_PreserveMountInfo(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail)));
} // DLA_Horse_PrepMountAnimation()


void privateDLA_DespawnPreMountHorse(object oHorse)
{ // PURPOSE: despawn - prevent horse duplicates
    if (GetIsObjectValid(oHorse))
    { // despawn
        DestroyObject(oHorse);
        DelayCommand(1.0,privateDLA_DespawnPreMountHorse(oHorse));
    } // despawn
} // privateDLA_DespawnPreMountHorse()


/*void DLA_Horse_MonitorMountSuccess(object oCreature,object oHorse,int bPlayAnimation,int bCutsceneMode,int nHorseTail)
{
  // This function uses nDLAMountState to
  // monitor how far the mounting process has successfully made it.  It will
  // resume the process from that point.

  int nState;
  effect eGhost=EffectCutsceneGhost();

  if (!DLA_GetIsMounted(oCreature))
  { // keep trying
    if (!GetIsObjectValid(oHorse))
    { // horse no longer exists
      AssignCommand(oCreature,SpeakString("No horse for me."));
      return;
    } // horse no longer exists

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oCreature,6.5);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oHorse,6.5);
    nState=GetLocalInt(oCreature,"nDLAMountState");
    DLA_HorseDebug("DLA_Horse_MonitorMountSuccess("+GetName(oCreature)+") recovery attempt");

    if (nState==0)
    { // never got as far as PrepMountAnimation()
      if (bPlayAnimation)
      { // fire prepanim
        DLA_HorseDebug("   State:0  Call PrepMountAnimation("+GetName(oCreature)+")");
        DLA_Horse_PrepMountAnimation(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail);
      } // fire prepanim
      else
      { // prepinfo
        DLA_HorseDebug("   State:0  Call PreserveMountInfo("+GetName(oCreature)+")");
        DLA_Horse_PreserveMountInfo(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail);
      } // prepinfo
    } // never got as far as PrepMountAnimation()
    else if (nState==1)
    { // never got as far as PreserveMountInfo()
      DLA_HorseDebug("   State:1  Call PreserveMountInfo("+GetName(oCreature)+")");
      DLA_Horse_PreserveMountInfo(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail);
    } // never got as far as PreserveMountInfo()
    else if (nState==2)
    { // Made it as far as the PreserveMountInfo() branch
      if (bPlayAnimation)
      { // animate mounting
        DLA_HorseDebug("   State:2  Call AnimateMounting("+GetName(oCreature)+")");
        AssignCommand(oCreature,ClearAllActions());
        DLA_Horse_AnimateMounting(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail);
      } // animate mounting
      else
      { // finalize mounting
        DLA_HorseDebug("   State:2  Call FinalizeMounting("+GetName(oCreature)+")");
        AssignCommand(oCreature,ClearAllActions());
        DLA_Horse_FinalizeMounted(oCreature,oHorse);
      } // finalize mounting
    } // Made it as far as the PreserveMountInfo() branch
    else if (nState==3)
    { // Did not make it to FinalizeMount()
      DLA_HorseDebug("   State:3  Call FinalizeMounting("+GetName(oCreature)+")");
      AssignCommand(oCreature,ClearAllActions());
      DLA_Horse_FinalizeMounted(oCreature,oHorse);
    } // Did not make it to FinalizeMount()
    DelayCommand(6.0,DLA_Horse_MonitorMountSuccess(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail));
  } // keep trying
  else
  { // mounted
    DLA_HorseDebug("   Mount Monitor reports successful mounting.["+GetName(oCreature)+"] "+IntToString(GetCreatureTailType(oCreature)));
    DeleteLocalInt(oCreature,"nDLAMountState");
    DelayCommand(2.0,SetCreatureTailType(GetCreatureTailType(oCreature),oCreature));
    DelayCommand(5.0,DLA_HorseDebug("  Tail for "+GetName(oCreature)+" is "+IntToString(GetCreatureTailType(oCreature))));
    //if(GetCreatureTailType(oCreature)!=GetLocalInt(oCreature,"nUseTail")) SetCreatureTailType(GetLocalInt(oCreature,"nUseTail"),oCreature);
    /*if (GetCreatureTailType(oCreature)<4)
    { // need tail
        DLA_HorseDebug("     TAIL FAILED: Applying="+IntToString(GetLocalInt(oCreature,"nUseTail")));
        SetCreatureTailType(GetLocalInt(oCreature,"nUseTail"),oCreature);
    } // need tail   */
    /*DeleteLocalInt(oCreature,"nUseTail");
    AssignCommand(oHorse,privateDLA_DespawnPreMountHorse(oHorse));
    if(!GetIsPC(oCreature))
    { // restore ai level
       SetAILevel(oCreature,GetLocalInt(oCreature,"nPreserveAILevel"));
       DeleteLocalInt(oCreature,"nPreserveAILevel");
    } // restore ai level      */
  //} // mounted
//} // DLA_Horse_MonitorMountSuccess()*/

/*void DLA_Mount(object oCreature, object oHorse, int bPlayAnimation=TRUE, int nHorseTail=DLA_HORSE_TAIL_AUTOMATIC)
{ // This function will handle mounting a PC or NPC upon a horse.
  // Deva B. Winblood 5/6/2006: Divided original code into several functions,
  // to distribute the CPU load and verify completion of actions in this script
  // happen properly.
  // Deva B. Winblood 6/15/2006 - Added check for non-standard appearances

  int bCutsceneMode=GetCutsceneMode(oCreature);
  effect eGhost=EffectCutsceneGhost();

  if (DLA_Horse_GetIsNotDefaultAppearance(oCreature))
  { // PC is shape shifted or polymorphed
    FloatingTextStringOnCreature("You may not mount while polymorphed or in alternate shapes!",oCreature,FALSE);
    DLA_HorseDebug("   You may not mount while in a non-standard appearance.");
    DeleteLocalInt(oHorse,"bTargetedForMount");
    return;
  } // PC is shape shifted or polymorphed

  if (GetLocalInt(oCreature, "DLA_CANT_MOUNT"))
  { // cannot move through this area
    //Gale 8 Dec 2005
    FloatingTextStringOnCreature("Horses cannot walk through this area.", oCreature, FALSE);
    DLA_HorseDebug("   Horses cannot walk in this area. Function returned.");
    DeleteLocalInt(oHorse,"bTargetedForMount");
    return;
  } // cannot move through this area

  //Dirge 17/06/05: You cannot mount if you have a tail.
  if(GetCreatureTailType(oCreature) != CREATURE_TAIL_TYPE_NONE)
  { // cannot mount if have tail - recommend removing and storing tail in future
    FloatingTextStringOnCreature("Your tail precludes the riding of a horse.", oCreature, FALSE);
    DLA_HorseDebug("   " + GetName(oCreature) + " has a tail and cannot ride a horse.  Function returned.");
    DeleteLocalInt(oHorse,"bTargetedForMount");
    return;
  } // cannot mount if have tail - recommend removing and storing tail in future
  */
  /* Removed for #1681 to allow model team members to correct.
  // Deva B. Winblood 6/15/2006 - per Mantis #1681 added check to prevent people
  // with wings from riding. - Alternative to consider in future would be remove
  // wings while mounted and restore them after dismount.
  if (GetCreatureWingType(oCreature)!=CREATURE_WING_TYPE_NONE)
  { // cannot mount if have wings
    FloatingTextStringOnCreature("Your wings prevent you from riding of a horse.",oCreature,FALSE);
    DLA_HorseDebug("   "+GetName(oCreature)+" has wings and cannot ride a horse.");
    DeleteLocalInt(oHorse,"bTargetedForMount");
    return;
  } // cannot mount if have wings
  */

 /* if (!GetIsObjectValid(oHorse) && nHorseTail>0)
  { // Change oCreature to mounted pheno and add nHorseTail.  bPlayAnimation is ignored.
    DLA_ChangeToMountedAppearance(oCreature);
    DLA_AddHorseTail(oCreature, nHorseTail);
  }

  if (DLA_GetIsPaladinMount(oHorse) && GetMaster(oHorse) != oCreature)
  { // Paladin mount will not allow any but master to mount
    FloatingTextStringOnCreature("The Paladin Mount senses you are not the paladin who called them",oCreature);
    AssignCommand(oHorse, ClearAllActions(TRUE));
    AssignCommand(oHorse, PlaySound("c_horse_hit2")); // Deva Winblood - 6/16/2006
    AssignCommand(oHorse, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT,1.0,4.0));
    DeleteLocalInt(oHorse, "bTargetedForMount");
    return;
  } // Paladin mount will not allow any but master to mount

  DeleteLocalInt(oCreature, "nDLAMountState");
  DLA_HorseDebug("<DLA_Mount>");
  DLA_HorseDebug("   " + GetName(oCreature) + " is trying to mount " +
                   GetName(oHorse) + " with animation set to " +
                   IntToString(bPlayAnimation) + " and a horse tail of " +
                   IntToString(nHorseTail) + ".");

  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oCreature,6.5);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oHorse,6.5);

  // Gale Nov 16, 2005: if mount animation is going to be played, and not yet on
  //cutscene mode, then set it.
  if (bPlayAnimation && !bCutsceneMode)
  { // play animation is selected but, not yet in cutscene mode
    SetCutsceneMode(oCreature, TRUE);
    DLA_HorseDebug("   Set cutscene mode for " + GetName(oCreature) + " to TRUE.");
  }

  // Gale Nov 16, 2005: Added support to tail type automatic.
  if (nHorseTail==DLA_HORSE_TAIL_AUTOMATIC)
  { // automatic horse tail was specified - find out what type of horse tail it is

    if (GetIsObjectValid(oHorse))
    { // the horse specified is valid
      nHorseTail = DLA_GetMountedHorseType(oHorse);
      SetLocalInt(oCreature,"nUseTail",DLA_GetMountedHorseType(oHorse));
      DLA_HorseDebug("   nHorseTail is set to automatic.  Using horse tail " + IntToString(nHorseTail) + ".");
    } // the horse specified is valid

    else
    { // no valid horse was specified
      DLA_HorseDebug("   nHorseTail is set to automatic but oHorse is not a valid object.  Function returned.");
      if (!bCutsceneMode)
            SetCutsceneMode(oCreature,FALSE);
      return; //error, TAIL set to AUTOMATIC, but oHorse is not valid.
    } // no valid horse was specified

  } // automatic horse tail was specified - find out what type of horse tail it is
  else
  { // not automatic
      SetLocalInt(oCreature,"nUseTail",nHorseTail);
  } // not automatic


  if (GetIsObjectValid(oHorse))
  { // a horse was specified

    if (!GetIsPC(oCreature))
    { // make NPC high AI level until done mounting
        SetLocalInt(oCreature,"nPreserveAILevel",GetAILevel(oCreature));
        SetAILevel(oCreature,AI_LEVEL_VERY_HIGH);
    } // make NPC high AI level until done mounting

    if (bPlayAnimation)
    { // animation time
      DLA_Horse_PrepMountAnimation(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail);
      DelayCommand(7.5,DLA_Horse_MonitorMountSuccess(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail));
    } // animation time
    else
    { // no animation needed
      DLA_Horse_PreserveMountInfo(oCreature,oHorse,bPlayAnimation,bCutsceneMode,nHorseTail);
    } // no animation needed

  } // a horse was specified
} // DLA_Mount() */


void DLA_UntieHorse(object oHorse)
{ //Deva B. Winblood  5/11/2006: Moved code from dla_d1_untie to this function
  //Added handling of each horse map pin by ID
  //Fixed the map pin not being correctly destroyed

  object oOwner;
  object oMapnote;

  int nID;

  if (GetIsObjectValid(oHorse))
  { // valid parameter was passed to this function

    oOwner=GetLocalObject(oHorse,"oDLA_HORSE_OWNER");
    oMapnote=GetLocalObject(oHorse,"dla_hitch");
    nID=GetLocalInt(oHorse,"nID");
    DLA_SetIsTied(oHorse,FALSE); // untie

    if (GetIsObjectValid(oMapnote))
    { // mapnote found
      //DestroyObject(oMapnote);
      SetMapPinEnabled(oMapnote,0);
      DeleteLocalObject(GetModule(),"oTied_Horse_Mapnote_"+IntToString(nID));
    } // mapnote found
    else
    { // could not find mapnote - search for it
      oMapnote=GetLocalObject(GetModule(),"oTied_Horse_Mapnote_"+IntToString(nID));
      if (GetIsObjectValid(oMapnote))
      { // found it
        //DestroyObject(oMapnote);
        SetMapPinEnabled(oMapnote,0);
        DeleteLocalObject(GetModule(),"oTied_Horse_Mapnote_"+IntToString(nID));
      } // found it
    } // could not find mapnote - search for it
  } // valid parameter was passed to this function
} // DLA_UntieHorse()


/*int DLA_Horse_GetIsNotDefaultAppearance(object oCreature)
{
   // 6/15/2006 - Deva Winblood
   // Used to prevent mounting while polymorphed, etc.
   int nAppearance=GetAppearanceType(oCreature);

   // always permit NPCs to shapeshift - module author may use non-standard
   // appearance intentionally
   if (!GetIsPC(oCreature)) return FALSE;

   if (nAppearance==APPEARANCE_TYPE_DWARF) return FALSE;
   else if (nAppearance==APPEARANCE_TYPE_ELF) return FALSE;
   else if (nAppearance==APPEARANCE_TYPE_GNOME) return FALSE;
   else if (nAppearance==APPEARANCE_TYPE_HALF_ELF) return FALSE;
   else if (nAppearance==APPEARANCE_TYPE_HALF_ORC) return FALSE;
   else if (nAppearance==APPEARANCE_TYPE_HALFLING) return FALSE;
   else if (nAppearance==APPEARANCE_TYPE_HUMAN) return FALSE;


   return TRUE;

}*/


int DLA_GetHorseID()
{
  // This ID will be flagged as used with oHorse_Instance_# ID is not
  // equal to OBJECT_INVALID.

  object oMod=GetModule();
  object oHorse;
  int nID = 1;

  oHorse = GetLocalObject(oMod,"oHorse_Instance_" + IntToString(nID));

  while(GetIsObjectValid(oHorse))
  { // look for unused ID
    nID++;
    oHorse = GetLocalObject(oMod,"oHorse_Instance_" + IntToString(nID));
  } // look for unused ID

  return nID;
} // DLA_GetHorseID()



void DLA_Horse_DropInventory(object oCreature,int bStarted=FALSE)
{ // PURPOSE: To drop every item carried by oCreature
    object oItem;
    object oCopy;
    int nStack;
    SetAILevel(oCreature,AI_LEVEL_HIGH);
    SetCommandable(TRUE,oCreature);
    if (!bStarted) oItem=GetFirstItemInInventory(oCreature);
    else { oItem=GetNextItemInInventory(oCreature); }
    if (GetIsObjectValid(oItem))
    { // carrying items
        //AssignCommand(oCreature,ActionPutDownItem(oItem));
        oCopy=CopyObject(oItem,GetLocation(oCreature));
        DelayCommand(0.02,DestroyObject(oItem));
        DelayCommand(0.02,DLA_Horse_DropInventory(oCreature,TRUE));
    } // carrying items
    else if (bStarted)
    { // insure everything is dropped
        oItem=GetFirstItemInInventory(oCreature);
        if (GetIsObjectValid(oItem))
        { // still carrying items
            DelayCommand(1.5,DLA_Horse_DropInventory(oCreature));
        } // still carrying items
    } // insure everything is dropped
} // DLA_Horse_DropInventory()


void DLA_DespawnPaladinMount(object oMount,int nKey=0)
{ // PURPOSE: Make sure inventory is dropped
    object oItem=GetFirstItemInInventory(oMount);
    int nSKey=GetLocalInt(oMount,"bDismountKey");
    PrintString("DLA_DespawnPaladinMount("+GetName(GetArea(oMount))+")");
    if (!GetIsObjectValid(oMount)) return;
    if (nSKey==0)
    { // set key
        nKey=Random(10000)+1;
        SetLocalInt(oMount,"bDismountKey",nKey);
    } // set key
    else if (nSKey!=0&&nSKey!=nKey) return ; // abort
    SetAILevel(oMount,AI_LEVEL_HIGH);
    SetCommandable(TRUE,oMount);
    //if (GetTag(GetArea(oMount))=="ThunderstoneTiltingGround") return;
    if (GetIsObjectValid(oItem))
    { // has inventory
        DLA_Horse_DropInventory(oMount);
        DelayCommand(2.0,DLA_DespawnPaladinMount(oMount,nKey));
    } // has inventory
    else
    { // destroy
        DestroyObject(oMount);
    } // destroy
} // DLA_DespawnPaladinMount()


//void main(){}
