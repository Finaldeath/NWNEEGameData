////////////////////////////////////////////////////////////////////////////////
// dla_i0_mount - Horse Mounting Rewrite to address potential issues that can
//                occur in mounting and have error trapping and redundancy
//                to account for lag issues.
// Script By: Deva B. Winblood & Dave Musser   6/23/2006
// Portions of this script are based on work by Gale, Ming, and Syrsnein.
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_animate"
#include "dla_i0_const"
#include "dla_i0_strings"
#include "x0_i0_position"
#include "dla_i0_debug"
#include "x0_inc_henai"


/*
DATE     | Tech Designer | Changes
=========+===============+======================================================
6/23/2006| Deva Winblood | Initial release of Generation 3 Horse Scripts
7/13/2006| Deva Winblood | Modified to fix ownership issues with horses
7/17/2006| Deva Winblood | Optimizations to deal with Lacinda's Horse issues
         |               | Additional ClearAllActions for DLA_StoreHorse added
         |               | to insure no accidental ActionFollows sneak in
7/20/2006| Deva Winblood | Added some AI flags to DLA_Store and DLA_Retrieve
         |               | horse functions to fight Lacinda Stalker Horse issues
7/29/2006| Deva Winblood | Added DLA_GetMountTimingMultiple() and made steps to
         |               | support bDefaulMountingEnabled, and fMountTimingMultiple
         |               | The details for these can be found in the above
         |               | listed function prototype.  This was all targeted at
         |               | addressing Mantis bug report #1905.
         |               | Also made it so horse is temporarily immobilized during
         |               | mounting so, it does not shift location when a PC or NPC
         |               | is animating mounting.
8/02/2006| Deva Winblood | Added DLA_NoHorseTransition() for properly handling
         |               | dismounting of all horses and hitching them before
         |               | doing the transition.  This is an alternate and more
         |               | complete replacement for DLA_RemoveAllHenchmenHorses()
         |               | which would not always wait for the horses to be hitched
         |               | before transitioning.
8/03/2006| Deva Winblood | Added DLA_SetAreaTransCameraFacing(oPC,oTarget) to the
         |               | jump in DLA_NoHorseTransition().  Also made NoHorse
         |               | transition no try to jump if oDestination is invalid.
8/04/2006| Deva Winblood | Modified DLA_StoreHorse() to handle destroying and
         |               | preserving information about LacHorse and preserving
         |               | inventory.  This is to address mantis #1997
8/05/2006| Deva Winblood | Added support for bHorseActionActive per mantis #2036
8/09/2006| Deva Winblood | Last minute emergency fixes for mantis #2056
8/10/2006| Deva Winblood | Hot Fixes for Stalker Horse and #2056 related.
9/15/2006| Deva Winblood | Removed negative skill effects while mounted per
         |               | Discussion with Georg Zoeller and Ben.

*/



///////////////////////////////////////
// CONSTANTS
///////////////////////////////////////

const int DLA_MOUNT_STATE_INIT             = 1; // initialization state
const int DLA_MOUNT_STATE_PRESERVE         = 2; // preserve information state
const int DLA_MOUNT_STATE_ADJUST           = 3; // adjust mount to fit rider
const int DLA_MOUNT_STATE_MOVE             = 4; // move into position state
const int DLA_MOUNT_STATE_ANIMATE          = 5; // animate the mounting
const int DLA_MOUNT_STATE_APPEAR           = 6; // appear mounted
const int DLA_MOUNT_STATE_COMPLETE         = 7; // complete mounting

const int DLA_MOUNT_DEBUG                  = FALSE; // Set to false for not debug

//////////////////////////////////////
// PROTOTYPES
//////////////////////////////////////

// FILE: dla_i0_mount
// This function will handle three styles of mounting
// #1 - if oHorse is invalid and a tail is specified it will rapidly switch the
//      oRider to the appropriate horse as specified by tail and will NOT animate.
//      This mode will not preserve any variables and should only be used for
//      cutscenes.
// #2 - if bPlayAnimation is set to TRUE it will still preserve critical
//      variables but, will not animate.  It will instantly make the PC mount.
//      This can also be done by setting the variable bDLAHorseNoAnimate to 1
//      on the module object.  In which case option #3 will never occur.
// #3 - If bPlayAnimation is set to TRUE it will perform positioning the PC and
//      horse and properly animating them.
// oRider = NPC or PC to mount.  They should be a standard racial type.
// oHorse = Target horse or mount to mount.
// bPlayAnimation = Whether to animate mounting or not
// nHorseTail = Which appearance horse tail to use.
// nState = internally set by these scripts, do not set this manually.
void DLA_Mount(object oRider, object oHorse, int bPlayAnimation=TRUE, int nHorseTail=DLA_HORSE_TAIL_AUTOMATIC,int nState=0);

// FILE: dla_i0_mount
// This will prep oHorse for mounting by oRider.  In this module this function
// is used to store the oHorse's current appearance #, switch it to the
// appropriate null race appearance, and tail.  This properly scales the horse
// for oRider.
void DLA_Horse_PrepHorse(object oRider,object oHorse);

// FILE: dla_i0_mount
// This will return the appearance that should be used when oRider is mounted.
int DLA_Horse_GetMountedAppearance(object oRider);

// FILE: dla_i0_mount
// This function will return the phenotype number that should be used when
// oRider is mounted.
int DLA_Horse_GetMountedPhenotype(object oRider);

// FILE: dla_i0_mount
// This function will return TRUE if it is okay for oRider to mount oHorse.
// If it is not then it will provide feedback to oRider and return FALSE.
int DLA_Horse_VerifyOkayToMount(object oRider,object oHorse);

// FILE: dla_i0_mount
// This function will return feedback.  If oRider is a PC and sPCMsg is
// specified it will provide that message as floaty text.  If oRider is
// an NPC and sNPCMsg is specified it will cause the NPC to speak that
// message.
void DLA_Horse_Feedback(object oRider,string sPCMsg,string sNPCMsg="");

// FILE: dla_i0_mount
// This function will return TRUE if oCreature is not currently in their
// default appearance.  This detects things such as wildshape, polymorph, etc.
int DLA_Horse_GetIsNotDefaultAppearance(object oCreature);

// FILE: dla_i0_mount
// This function will return mount debug information if the variable
// DLA_MOUNT_DEBUG (defined in dla_i0_mount) is TRUE.
void DLA_MountDebug(string sMsg,string sColor="");

// FILE: dla_i0_mount
// This will return true if oHenchman is a paladin mount
int DLA_GetIsPaladinMount(object oHenchman);

// FILE: dla_i0_mount
// This function is private and is only called by DLA_Mount.
// Transfer equipment from horse packs to a temporary storage
void DLA_Horse_TransferEquipment(object oHorse,object oCreature);

// FILE: dla_i0_mount
// This function will return the null appearance number to use for oRider.
// Used for resizing horses.
int DLA_Horse_GetNullAppearance(object oRider);


// FILE: dla_i0_mount
// Gale Nov 2005:
// Returns the number of the horse tail based on the appearance type... if not
// a horse-designed appearance, returns APPEARANCE_TYPE_INVALID.
int DLA_GetMountedHorseType(object oHorse);

// FILE: dla_i0_mount
// This function will move the horse to a safe holding area and will reduce it's
// AI and make not commandable.  This is where a horse is stored while mounted.
void DLA_StoreHorse(object oHorse);

// FILE: dla_i0_mount
// This function will retrieve a horse from storage that was placed there using
// the DLA_StoreHorse() function.  This is intended for the dismount process.
void DLA_RetrieveHorse(object oHorse,location lLoc);


// FILE: dla_i0_mount
// This function will retrieve an alternate phenotype to cycle between
// to hopefully fix horse hat and sinkage.
int DLA_GetAlternatePheno(object oRider);


// FILE: dla_i0_mount
// This function will retrieve fMountTimingMultiple from the module object.
// If bDefaultMountingEnabled is set to 1 on the module object then it will
// instead return 1.0.  This is used for adjusting pause and timing of the
// mounting process and in particular is addressing mantis bug report #1905.
float DLA_GetMountTimingMultiple();


// FILE: dla_i0_mount
// This function will make sure oPC and all their henchmen are not mounted.  It
// will remove any horses from the party.  If bAnimate is TRUE it will play
// dismount animations as appropriate.  If bHitch is TRUE it will hitch horses.
// nState is used internally and should not need to be set by your script.  When
// everything is properly handled oPC will transition to oDestination.  bAnnounced
// is used internally.  oPost allows you to specify a specific hitching post to use
void DLA_NoHorseTransition(object oPC,object oDestination,int bAnimate=TRUE,int bHitch=TRUE,object oPost=OBJECT_INVALID,int nState=0,int bAnnounced=FALSE);


//////////////////////////////////////
// MOUNT SUB-FUNCTION PROTOTYPES
//////////////////////////////////////

// FILE: dla_i0_mount
// This function is part of the mounting state machine.  It's duty is to prep
// the initial values required for mounting.
void DLA_State_Initialize(object oRider,object oHorse,int bPlayAnimation,int nHorseTail);

// FILE: dla_i0_mount
// This function will preserve the inventory and vital information about oHorse.
// This function is part of the mounting state machine.
// NOT USED AS OF 6/28/2006 build
void DLA_State_Preserve(object oRider,object oHorse,int bPlayAnimation,int nHorseTail);

// FILE: dla_i0_mount
// This function will set the horsetail as something known finally.
// It will also adjust the size of the horse if not known yet.  This function
// is part of the mounting state machine.
void DLA_State_Adjust(object oRider,object oHorse,int bPlayAnimation,int nHorseTail);

// FILE: dla_i0_mount
// This will move oHorse and oRider into proper mounting position
// This function is part of the mounting state machine.
void DLA_State_Move(object oRider,object oHorse,int nHorseTail);


// FILE: dla_i0_mount
// This will cause oRider to animate mounting oHorse.
// This function is part of the mounting state machine.
void DLA_State_Animate(object oRider,object oHorse,int nHorseTail);


// FILE: dla_i0_mount
// This will cause oRider to switch to proper full mounted appearance and
// will not continue until the change is complete.
void DLA_State_Appear(object oRider,object oHorse,int nHorseTail);


// FILE: dla_i0_mount
// This function completes the mounting process.
// This function is part of the mounting state machine.
void DLA_State_Complete(object oRider,object oHorse);



//////////////////////////////////////
// EXTERNAL PROTOTYPES
//////////////////////////////////////

void DLA_RefreshMovementSpeed(object oCreature);
void DLA_Dismount (object oCreature, int bPlayAnimation = TRUE, int bAddAsHenchman = TRUE, int bHitchHorse = FALSE, object oNewOwner = OBJECT_INVALID);
int DLA_GetIsMounted(object oCreature);
int DLA_GetIsDLAHorse(object oCreature);
void DLA_RemoveHenchman(object oMaster, object oHenchman=OBJECT_SELF, int bResetName = TRUE, int bSetAsFormerMaster = FALSE);
void DLA_SetIsTied(object oHorse=OBJECT_SELF, int bTied=TRUE);
int DLA_GetHorseID();
void DLA_UnequipShield(object oPC, object oItem=OBJECT_INVALID);
void DLA_SetAreaTransCameraFacing(object oPC, object oDestination, int nTransCam = CAMERA_TRANSITION_TYPE_SNAP, object oSource=OBJECT_SELF);

//////////////////////////////////////
// FUNCTIONS
//////////////////////////////////////



void DLA_Mount(object oRider, object oHorse, int bPlayAnimation=TRUE, int nHorseTail=DLA_HORSE_TAIL_AUTOMATIC,int nState=0)
{ // PURPOSE: To handle the mounting of a horse
    object oOb;   // generic object
    int nN;       // generic integer
    string sS;    // generic string
    location lLoc;// generic location
    int nTrueState=nState;
    int bAnimate=bPlayAnimation;

    DLA_MountDebug("DLA_Mount("+GetName(oRider)+","+GetName(oHorse)+","+IntToString(bPlayAnimation)+","+IntToString(nHorseTail)+",STATE:"+IntToString(nState)+")","");

    if (GetLocalInt(GetModule(),"bDLAHorseNoAnimate")) bAnimate=FALSE;

    if (GetIsObjectValid(oRider))
    { // oRider is valid

        if (!GetIsObjectValid(oHorse)&&nHorseTail>0&&nState==0)
        { // option #1 - rapid mount
            DLA_MountDebug("   Rapid Mount!","666");
            nN=DLA_Horse_GetMountedAppearance(oRider);
            SetCreatureAppearanceType(oRider,nN);
            nN=DLA_Horse_GetMountedPhenotype(oRider);
            SetPhenoType(nN,oRider);
            SetCreatureTailType(nHorseTail,oRider);  // Deva   6/28/2006
        } // option #1 - rapid mount
        else
        { // not the rapid option

            if (!GetCutsceneMode(oRider))
              SetLocalInt(oRider,"bMountEndCutscene",TRUE);  // Dave  6/26/2006

            if (nTrueState==0)
            { // initialize state system
                AssignCommand(oRider,ClearAllActions(TRUE));
                AssignCommand(oHorse,ClearAllActions(TRUE));
                SetLocalInt(oRider,"nDLAMountState",1);
                DelayCommand(0.01,DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_INIT));
            } // initialize state system

            nTrueState=GetLocalInt(oRider,"nDLAMountState");

            DLA_MountDebug("   State:"+IntToString(nState)+"  TrueState:"+IntToString(nTrueState));

            if (nTrueState==nState&&(DLA_Horse_VerifyOkayToMount(oRider,oHorse)||nState>DLA_MOUNT_STATE_ANIMATE))
            { // state and true state match - safe to continue

                switch(nState)
                { // mounting state system
                    case DLA_MOUNT_STATE_INIT:
                    { // case - initialize the mounting process
                        DLA_MountDebug("  INITIALIZE","666");
                        DLA_State_Initialize(oRider,oHorse,bAnimate,nHorseTail);
                        DelayCommand(1.03*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_INIT));
                        break;
                    } // case - initialize the mounting process
                    case DLA_MOUNT_STATE_PRESERVE:
                    { // case - preserve vital information
                        DLA_MountDebug("  PRESERVE","666");
                        DLA_State_Preserve(oRider,oHorse,bAnimate,nHorseTail);
                        DelayCommand(8.0*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_PRESERVE));
                        break;
                    } // case - preserve vital information
                    case DLA_MOUNT_STATE_ADJUST:
                    { // case - adjust mount to rider race
                        DLA_MountDebug("  ADJUST","666");
                        DLA_State_Adjust(oRider,oHorse,bAnimate,nHorseTail);
                        DelayCommand(1.27*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_ADJUST));
                        break;
                    } // case - adjust mount to rider race
                    case DLA_MOUNT_STATE_MOVE:
                    { // case - anim - move to mount
                        DLA_MountDebug("  MOVE","666");
                        DLA_State_Move(oRider,oHorse,nHorseTail);
                        DelayCommand(8.0*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_MOVE));
                        break;
                    } // case - anim - move to mount
                    case DLA_MOUNT_STATE_ANIMATE:
                    { // case - anim - animate mounting
                        DLA_MountDebug("  ANIMATE","666");
                        DLA_State_Animate(oRider,oHorse,nHorseTail);
                        DelayCommand(6.0*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_ANIMATE));
                        break;
                    } // case - anim - animate mounting
                    case DLA_MOUNT_STATE_APPEAR:
                    { // case - set appearance of oRider
                        DLA_MountDebug("  APPEAR","666");
                        DLA_State_Appear(oRider,oHorse,nHorseTail);
                        DelayCommand(2.36*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_APPEAR));
                        break;
                    } // case - set appearance of oRider
                    case DLA_MOUNT_STATE_COMPLETE:
                    { // case - complete the mounting process
                        DLA_MountDebug("  COMPLETE","666");
                        DLA_State_Complete(oRider,oHorse);
                        DelayCommand(4.0*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,bAnimate,nHorseTail,DLA_MOUNT_STATE_COMPLETE));
                        break;
                    } // case - complete the mounting process
                    default: break;
                } // mounting state system

            } // state and true state match - safe to continue
            else
            { // abort

                DLA_MountDebug("     Aborted State:"+IntToString(nState),"622");

            } // abort

        } // not the rapid option

    } // oRider is valid

} // DLA_Mount()



void DLA_Horse_VerifyValidMounted(object oRider)
{ // PURPOSE: Make sure appearance and mounted are correct
    int nPheno=DLA_Horse_GetMountedPhenotype(oRider);
    int nApp=DLA_Horse_GetMountedAppearance(oRider);
    int nCurP=GetPhenoType(oRider);
    int nCurA=GetAppearanceType(oRider);
    int nTail=GetCreatureTailType(oRider);

    DLA_MountDebug("  DLA_HorseVerifyValidMounted("+GetName(oRider)+") Current/Desired Phenotype="+IntToString(nCurP)+"/"+IntToString(nPheno)+" nAppearance="+IntToString(nCurA)+"/"+IntToString(nApp)+"  nTail="+IntToString(nTail),"226");

    if (nCurA!=nApp||nCurP!=nPheno)
    { // fix horse hat
        DLA_MountDebug("        Try to fix");
        DelayCommand(1.0,SetPhenoType(nPheno,oRider));
        DelayCommand(1.2,SetCreatureAppearanceType(oRider,nApp));
        DelayCommand(1.5,DLA_Horse_VerifyValidMounted(oRider));
    } // fix horse hat
    else
    { // do it anyway
        DelayCommand(0.01,SetCreatureTailType(nTail+DLA_HORSE_TAIL_OFFSET,oRider));
        DelayCommand(0.2,SetCreatureTailType(nTail,oRider));
        DelayCommand(0.6,SetPhenoType(GetLocalInt(oRider,"nDLAAltPheno"),oRider));
        DelayCommand(1.0,SetCreatureTailType(nTail+DLA_HORSE_TAIL_OFFSET,oRider));
        DelayCommand(1.4,SetPhenoType(nPheno,oRider));
        DelayCommand(1.8,SetCreatureAppearanceType(oRider,nApp));
        DelayCommand(2.2,SetCreatureTailType(nTail,oRider));
    } // do it anyway

} // DLA_Horse_VerifyValidMounted()



int DLA_Horse_VerifyOkayToMount(object oRider,object oHorse)
{ // PURPOSE: Will return TRUE if it is okay for oRider to mount oHorse
  // otherwise it will return FALSE and provide feedback to oRider.

    if (GetLocalInt(oRider,"nDLAMountState")>DLA_MOUNT_STATE_INIT) return TRUE;

    if (GetLocalInt(oHorse,"bBeingMounted"))
    { // the horse is already in the process of being mounted
        DLA_Horse_Feedback(oRider,"A henchman is already mounting that horse!","Someone is mounting the horse I wanted.");
        DeleteLocalInt(oHorse,"bTargetedForMount");
        DeleteLocalInt(oRider,"bHorseActionActive");
        return FALSE;
    } // the horse is already in the process of being mounted

    if (DLA_Horse_GetIsNotDefaultAppearance(oRider))
    { // oRider is shape shifted
        DLA_Horse_Feedback(oRider,"Not while shape shifted!","I cannot ride a horse.");
        DeleteLocalInt(oHorse,"bTargetedForMount");
        DeleteLocalInt(oRider,"bHorseActionActive");
        return FALSE;
    } // oRider is shape shifted

    if (GetLocalInt(oRider,"DLA_CANT_MOUNT"))
    { // horses cannot walk through this area
        DLA_Horse_Feedback(oRider,"Horses may not be mounted in this area!","I can't do that here.");
        DeleteLocalInt(oHorse,"bTargetedForMount");
        DeleteLocalInt(oRider,"bHorseActionActive");
        return FALSE;
    } // horses cannot walk through this area

    if(GetCreatureTailType(oRider)!=CREATURE_TAIL_TYPE_NONE && GetCreatureTailType(oRider)!=68)
    { // creatures with tails may not mount
        DLA_Horse_Feedback(oRider,"Your tail prevents mounting!","Riding is uncomfortable.");
        DeleteLocalInt(oHorse,"bTargetedForMount");
        DeleteLocalInt(oRider,"bHorseActionActive");
        return FALSE;
    } // creatures with tails may not mount

    if (DLA_GetIsPaladinMount(oHorse)&&GetMaster(oHorse)!=oRider)
    { // this is a paladin mount and oRider is not it's master
        DLA_Horse_Feedback(oRider,"The Paladin's Mount does not belong to you!","I can't ride that thing!");
        AssignCommand(oHorse, ClearAllActions(TRUE));
        AssignCommand(oHorse, PlaySound("c_horse_hit2")); // Deva Winblood - 6/16/2006
        AssignCommand(oHorse, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT,1.0,4.0));
        DeleteLocalInt(oHorse, "bTargetedForMount");
        DeleteLocalInt(oRider,"bHorseActionActive");
        return FALSE;
    } // this is a paladin mount and oRider is not it's master

    return TRUE;
} // DLA_Horse_VerifyOkayToMount()



void DLA_Horse_Feedback(object oRider,string sPCMsg,string sNPCMsg="")
{ // PURPOSE: To provide messaying support for this dla_i0_mount

    if (GetIsPC(oRider)||GetIsDM(oRider)||GetIsDMPossessed(oRider))
    { // PC

        if (GetStringLength(sPCMsg)>0)
        { // PC message sent
            FloatingTextStringOnCreature(sPCMsg,oRider,FALSE);
        } // PC message sent

    } // PC
    else
    { // NPC

        if (GetStringLength(sNPCMsg)>0)
        { // NPC message sent
            AssignCommand(oRider,SpeakString(sNPCMsg));
        } // NPC message sent

    } // NPC

} // DLA_Horse_Feedback()



int DLA_Horse_GetIsNotDefaultAppearance(object oCreature)
{  // PURPOSE: To return whether oCreature has been polymorphed, etc.
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
}  // DLA_Horse_GetIsNotDefaultAppearance()



void DLA_MountDebug(string sMsg,string sColor="")
{ // PURPOSE: To send color formatted messages as debug information
    string sOut=sMsg;
    if (!DLA_MOUNT_DEBUG||GetLocalInt(GetModule(),"bDebugOff")) return;
    if (GetStringLength(sColor)==3)
    { // set color
        sOut=DLA_SetStringColor(sOut,sColor);
    } // set color
    DLA_Debug(sOut);
//    SendMessageToPC(GetFirstPC(),sOut);
} // DLA_MountDebug()



int DLA_GetIsPaladinMount(object oHenchman)
{ // Gale
  return GetStringLeft(GetResRef(oHenchman), 12) == "dla_palhorse";
} // DLA_GetIsPaladinMount()



int DLA_Horse_GetMountedAppearance(object oRider)
{ // PURPOSE: To return the appearance oRider should use
  // script by Gale or Ming

    if (GetIsObjectValid(oRider))
    { // valid parameters

      if (GetGender(oRider) == GENDER_MALE)
      { // if male

          switch(GetAppearanceType(oRider))
          {
              case APPEARANCE_TYPE_DWARF         : return DLA_HORSE_APPEARANCE_DWARF_MALE;
              case APPEARANCE_TYPE_ELF           : return DLA_HORSE_APPEARANCE_ELF_MALE;
              case APPEARANCE_TYPE_GNOME         : return DLA_HORSE_APPEARANCE_GNOME_MALE;
              case APPEARANCE_TYPE_HALFLING      : return DLA_HORSE_APPEARANCE_HALFLING_MALE;
              case APPEARANCE_TYPE_HALF_ELF      : return DLA_HORSE_APPEARANCE_HALF_ELF_MALE;
              case APPEARANCE_TYPE_HALF_ORC      : return DLA_HORSE_APPEARANCE_HALF_ORC_MALE;
              case APPEARANCE_TYPE_HUMAN         : return DLA_HORSE_APPEARANCE_HUMAN_MALE;
          }

      } // if male
      else
      { // not male

          switch(GetAppearanceType(oRider))
          {
              case APPEARANCE_TYPE_DWARF         : return DLA_HORSE_APPEARANCE_DWARF_FEMALE;
              case APPEARANCE_TYPE_ELF           : return DLA_HORSE_APPEARANCE_ELF_FEMALE;
              case APPEARANCE_TYPE_GNOME         : return DLA_HORSE_APPEARANCE_GNOME_FEMALE;
              case APPEARANCE_TYPE_HALFLING      : return DLA_HORSE_APPEARANCE_HALFLING_FEMALE;
              case APPEARANCE_TYPE_HALF_ELF      : return DLA_HORSE_APPEARANCE_HALF_ELF_FEMALE;
              case APPEARANCE_TYPE_HALF_ORC      : return DLA_HORSE_APPEARANCE_HALF_ORC_FEMALE;
              case APPEARANCE_TYPE_HUMAN         : return DLA_HORSE_APPEARANCE_HUMAN_FEMALE;
          }

      }  // not male

    } // valid parameters

    return GetAppearanceType(oRider);
} // DLA_Horse_GetMountedAppearance()


int DLA_Horse_GetMountedPhenotype(object oRider)
{ // PURPOSE: Return phenotype oRider should use when mounted
  // Based on work by Gale
    int nPheno=GetPhenoType(oRider);

    switch(nPheno)
    { // check phenotype

        case PHENOTYPE_NORMAL:
        case PHENOTYPE_DLA_JOUSTING_NORMAL:
        { // normal or normal jousting
            return PHENOTYPE_DLA_MOUNTED_NORMAL;
        } // normal or normal jousting
        case PHENOTYPE_DLA_JOUSTING_BIG:
        case PHENOTYPE_BIG:
        { // big or big jousting
            return PHENOTYPE_DLA_MOUNTED_BIG;
        } // big or big jousting

        default: break;
    } // check phenotype

    return nPheno;
} // DLA_Horse_GetMountedPhenotype()


int DLA_GetAlternatePheno(object oRider)
{ // PURPOSE: Return alternate pheno

    int nPheno=GetPhenoType(oRider);

    switch(nPheno)
    { // switch

        case PHENOTYPE_NORMAL:
        case PHENOTYPE_DLA_MOUNTED_NORMAL:
        { // normal
             return PHENOTYPE_DLA_JOUSTING_NORMAL;
        } // normal
        case PHENOTYPE_DLA_MOUNTED_BIG:
        case PHENOTYPE_BIG:
        { // big
             return PHENOTYPE_DLA_JOUSTING_BIG;
        } // big

    } // switch

    return nPheno;
} // DLA_GetAlternatePheno()



void DLA_State_Initialize(object oRider,object oHorse,int bPlayAnimation,int nHorseTail)
{ // PURPOSE: To setup initial settings for mounting.
    int nPheno=DLA_Horse_GetMountedPhenotype(oRider);
    int nApp=DLA_Horse_GetMountedAppearance(oRider);
    int nHorse=GetAppearanceType(oHorse);
    int nHorseTail=GetCreatureTailType(oHorse);
    location lLoc=GetLocation(oHorse);
    effect eGhost=EffectCutsceneGhost();
    effect eInvis=EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect eImmobilize=EffectCutsceneImmobilize();


    //SetAILevel(oRider,AI_LEVEL_VERY_HIGH);

    if ((GetIsPC(oRider)||GetIsDM(oRider)||GetIsDMPossessed(oRider))&&!GetCutsceneMode(oRider))
            SetCutsceneMode(oRider,TRUE);  // Dave   6/26/2006

    DLA_MountDebug("DLA_State_Initialize("+GetName(oRider)+","+GetName(oHorse)+","+IntToString(bPlayAnimation)+","+IntToString(nHorseTail));

    SetLocalObject(oRider,"oDLAMyMount",oHorse);
    SetLocalObject(oHorse,"oDLAMyMaster",GetMaster(oHorse));
    SetLocalInt(oRider,"nDLAMountedPheno",nPheno);
    SetLocalInt(oRider,"nDLAMountedAppearance",nApp);
    SetLocalInt(oRider,"nDLADefaultPheno",GetPhenoType(oRider));
    SetLocalInt(oRider,"nDLAAltPheno",DLA_GetAlternatePheno(oRider));
    SetLocalInt(oRider,"nDLAMountedOriginalHorseApp",nHorse);
    SetLocalInt(oRider,"nDLAMountedOriginalHorseTail",nHorseTail);
    SetLocalString(oRider,"sDLA_Horse",GetResRef(oHorse));
    SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_PRESERVE);
    SetLocalString(oRider,"sHorseTag",GetTag(oHorse));
    SetLocalObject(oRider,"oDLA_HORSE_OWNER",GetLocalObject(oHorse,"oDLA_HORSE_OWNER"));
    SetLocalInt(oHorse,"bBeingMounted",TRUE);
    if (GetLocalInt(oHorse,"bLacindasOwnedHorse"))
    { // preserve lacinda's variable
         SetLocalInt(oRider,"bLacindasOwnedHorse",TRUE);
    } // preserve lacinda's variable
    SetLocalInt(oRider,"iDLA_Horse_App",GetAppearanceType(oHorse));
    SetLocalInt(oRider,"iDLA_HorseHP",GetCurrentHitPoints(oHorse));
    SetLocalObject(oRider,"oDLAHorseAssigned",GetLocalObject(oHorse,"oAssigned"));
    DLA_UnequipShield(oRider);

    if (DLA_GetIsPaladinMount(oHorse))
    { // make sure to preserve paladin mount despawn time
         SetLocalInt(oRider,"nPalHorseDespawnTime",GetLocalInt(oHorse,"nDespawnHour"));
    } // make sure to preserve paladin mount despawn time

    if (bPlayAnimation)
    { // animate
        SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_ADJUST);
        DelayCommand(0.03,DLA_Mount(oRider,oHorse,bPlayAnimation,nHorseTail,DLA_MOUNT_STATE_ADJUST));
    } // animate
    else
    { // do not animate
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oHorse,4.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmobilize,oHorse,4.0);
        AssignCommand(oRider,ClearAllActions(TRUE));
        AssignCommand(oRider,JumpToLocation(lLoc));
        AssignCommand(oRider,SetFacing(GetFacing(oHorse)));
        AssignCommand(oRider,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM6,1.0,2.0));
        DelayCommand(0.5*DLA_GetMountTimingMultiple(),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oHorse,4.0));
        SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_APPEAR);
        DelayCommand(0.03,DLA_Mount(oRider,oHorse,bPlayAnimation,nHorseTail,DLA_MOUNT_STATE_APPEAR));
    } // do not animate
} // DLA_State_Initialize()


// Preserve was no longer needed as of 6/28/2006 change by Deva
void DLA_State_Preserve(object oRider,object oHorse,int bPlayAnimation,int nHorseTail)
{ // PURPOSE: To preserve vital information about oHorse and to transfer it's inventory
    int nID=GetLocalInt(oHorse,"nID");
    object oPacks;
    object oItem;


    DLA_MountDebug("DLA_State_Preserve("+GetName(oRider)+","+GetName(oHorse)+","+IntToString(bPlayAnimation)+","+IntToString(nHorseTail));

    if (!GetLocalInt(oHorse,"bDLAPreserved"))
    { // vitals not preserved

        DLA_MountDebug("  Preserving Vitals "+GetName(oRider)+" for "+GetName(oHorse));

        SetLocalString(oRider,"sDLA_Horse",GetResRef(oHorse));
        SetLocalInt(oRider,"iDLA_Horse_App",GetAppearanceType(oHorse));
        SetLocalInt(oRider,"iDLA_HorseHP",GetCurrentHitPoints(oHorse));
        SetLocalObject(oRider,"oDLA_HORSE_OWNER",GetLocalObject(oHorse,"oDLA_HORSE_OWNER"));
        SetLocalObject(oRider,"oDLAHorseAssigned",GetLocalObject(oHorse,"oAssigned"));

        if (DLA_GetIsPaladinMount(oHorse))
        { // make sure to preserve paladin mount despawn time
            SetLocalInt(oRider,"nPalHorseDespawnTime",GetLocalInt(oHorse,"nDespawnHour"));
        } // make sure to preserve paladin mount despawn time

        SetLocalInt(oRider,"nHorseID",nID);
        SetLocalString(oRider,"sHorseTag",GetTag(oHorse));

        if (GetLocalInt(oHorse,"bLacindasOwnedHorse"))
        { // preserve lacinda's variable
            SetLocalInt(oRider,"bLacindasOwnedHorse",TRUE);
        } // preserve lacinda's variable

        SetLocalInt(oHorse,"bDLAPreserved",TRUE);

        DelayCommand(0.01,DLA_State_Preserve(oRider,oHorse,bPlayAnimation,nHorseTail));

    } // vitals not preserved
    else if (GetIsObjectValid(GetFirstItemInInventory(oHorse)))
    { // inventory not transferred

        DLA_MountDebug("  Transfer Inventory","622");

        if (!GetIsObjectValid(GetLocalObject(oRider,"dla_horse_packs")))
        { // transfer inventory
            DLA_Horse_TransferEquipment(oHorse,oRider);
        } // transfer inventory

        DelayCommand(0.2,DLA_State_Preserve(oRider,oHorse,bPlayAnimation,nHorseTail));

    } // inventory not transferred
    else
    { // completed

        if (bPlayAnimation)
        { // animate

            SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_ADJUST);
            DelayCommand(0.1,DLA_Mount(oRider,oHorse,bPlayAnimation,nHorseTail,DLA_MOUNT_STATE_ADJUST));

        } // animate
        else
        { // do not animate

            DelayCommand(0.1,SetCreatureAppearanceType(oRider,GetLocalInt(oRider,"nDLAMountedAppearance")));
            DelayCommand(0.3,SetPhenoType(GetLocalInt(oRider,"nDLAMountedPheno"),oRider));
            SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_APPEAR);
            DelayCommand(0.2,DLA_Mount(oRider,oHorse,bPlayAnimation,nHorseTail,DLA_MOUNT_STATE_APPEAR));

        } // do not animate

    } // completed

} // DLA_State_Preserve()


// Not needed as of 6/28/2006 build by Deva
void DLA_Horse_TransferEquipment(object oHorse,object oCreature)
{
  object oPacks;
  object oItem;
  object oCopy;

  DLA_MountDebug("   Horse has packs.  Filling packs with items.");

  oPacks = CreateObject( OBJECT_TYPE_PLACEABLE, DLA_TAG_HORSE_PACKS, GetLocation(oCreature), FALSE );
  oItem = GetFirstItemInInventory(oHorse);
  SetLocalObject(oCreature, "dla_horse_packs", oPacks);

  while (GetIsObjectValid(oItem))
  {  // while items remain in the inventory
       oCopy=CopyItem(oItem,oPacks,TRUE);
       DelayCommand(0.1,DestroyObject(oItem));
       oItem = GetNextItemInInventory(oHorse);
  }  // while items remain in the inventory
  //

  // Deva Winblood  May 24,2006 - do not destroy horse until mounting confirmed
  //DLA_HorseDebug("   DLA_DestroyHorseHenchman("+GetName(oCreature)+","+GetName(oHorse)+") DLA_Horse_TransferEquipment()");
  DelayCommand(0.2,DestroyObject(oHorse));

} // DLA_Horse_TransferEquipment()


int DLA_Horse_GetNullAppearance(object oRider)
{ // PURPOSE: To return the null appearance for oRider

    switch(GetRacialType(oRider))
    { // racial type switch

        case RACIAL_TYPE_DWARF:      return 560;
        case RACIAL_TYPE_ELF:        return 561;
        case RACIAL_TYPE_GNOME:      return 562;
        case RACIAL_TYPE_HALFELF:    return 564;
        case RACIAL_TYPE_HALFLING:   return 563;
        case RACIAL_TYPE_HALFORC:    return 565;
        case RACIAL_TYPE_HUMAN:      return 566;

    } // racial type switch

    return 0;
} // DLA_Horse_GetNullAppearance()


void DLA_State_Adjust(object oRider,object oHorse,int bPlayAnimation,int nHorseTail)
{ // PURPOSE: To Preserve accurate horsetail information and to adjust the
  // size of the horse to properly reflect the rider size

    int nTail=nHorseTail;
    int nApp=DLA_Horse_GetNullAppearance(oRider);
    effect eGhost=EffectCutsceneGhost();
    effect eImmobilize=EffectCutsceneImmobilize();

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oHorse,6.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oRider,6.0);

    DLA_MountDebug("DLA_State_Adjust("+GetName(oRider)+","+GetName(oHorse)+","+IntToString(bPlayAnimation)+","+IntToString(nHorseTail));

    if (!GetLocalInt(oHorse,"bAdjusted"))
    { // not adjusted yet

        if (nTail==DLA_HORSE_TAIL_AUTOMATIC||nTail==0)
        { // determine tail

            nTail=DLA_GetMountedHorseType(oHorse);

        } // determine tail

        DLA_MountDebug("   Null Appearance:"+IntToString(nApp)+"  nTail:"+IntToString(nTail));

        SetLocalInt(oHorse,"nDesiredTail",nTail);
        SetLocalInt(oHorse,"nDesiredApp",nApp);
        SetLocalInt(oHorse,"bAdjusted",TRUE);
        DelayCommand(0.02,DLA_State_Adjust(oRider,oHorse,bPlayAnimation,nTail));

    } // not adjusted yet
    else
    { // adjust

        nTail=GetLocalInt(oHorse,"nDesiredTail");
        nApp=GetLocalInt(oHorse,"nDesiredApp");

        DLA_MountDebug("   nDesiredTail="+IntToString(nTail)+" actual="+IntToString(GetCreatureTailType(oHorse))+"  nDesiredApp="+IntToString(nApp)+" actual="+IntToString(GetAppearanceType(oHorse)));

        if (GetAppearanceType(oHorse)!=nApp)
        { // adjust horse appearance

            SetCreatureAppearanceType(oHorse,nApp);
            DelayCommand(0.1*DLA_GetMountTimingMultiple(),DLA_State_Adjust(oRider,oHorse,bPlayAnimation,nTail));

        } // adjust horse appearance
        else if (GetCreatureTailType(oHorse)!=nTail)
        { // adjust tail type

            SetCreatureTailType(nTail,oHorse);
            DelayCommand(0.1*DLA_GetMountTimingMultiple(),DLA_State_Adjust(oRider,oHorse,bPlayAnimation,nTail));

        } // adjust tail type
        else
        { // done

            SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_MOVE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eImmobilize,oHorse,6.0*DLA_GetMountTimingMultiple());
            DelayCommand(0.05,DLA_Mount(oRider,oHorse,bPlayAnimation,nHorseTail,DLA_MOUNT_STATE_MOVE));

        } // done

    } // adjust

} // DLA_State_Adjust()



void DLA_State_Move(object oRider,object oHorse,int nHorseTail)
{ // PURPOSE: To Move oRider and oHorse into position for mounting

    location lStep=GetStepLeftLocation(oHorse);
    location lRider=DLA_Horse_GetAnimationProxyLocation(oHorse,-90.0);
    location lHorse;
    int nCount=GetLocalInt(oRider,"nDLAMountMoveCount");

    DLA_MountDebug("DLA_State_Move("+GetName(oRider)+","+GetName(oHorse)+","+IntToString(nHorseTail));

    if (GetDistanceBetweenLocations(GetLocation(oRider),lStep)>0.1)
    { // move

        nCount++;
        SetLocalInt(oRider,"nDLAMountMoveCount",nCount);

        if (nCount<5)
        { // move rider

            AssignCommand(oRider,ClearAllActions(TRUE));
            AssignCommand(oRider,ActionMoveToLocation(lStep,TRUE));
            DelayCommand(1.0*DLA_GetMountTimingMultiple(),DLA_State_Move(oRider,oHorse,nHorseTail));

        } // move rider
        else if (nCount<10)
        { // move horse

            lHorse=DLA_Horse_GetAnimationProxyLocation(oRider);
            AssignCommand(oRider,ClearAllActions(TRUE));
            AssignCommand(oHorse,ClearAllActions(TRUE));
            AssignCommand(oHorse,JumpToLocation(lHorse));
            DelayCommand(0.3*DLA_GetMountTimingMultiple(),DLA_State_Move(oRider,oHorse,nHorseTail));

        } // move horse
        else
        { // don't animate

            SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_APPEAR);
            DelayCommand(0.1*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,TRUE,nHorseTail,DLA_MOUNT_STATE_APPEAR));

        } // don't animate

    } // move
    else
    { // in position

        DeleteLocalInt(oRider,"nDLAMountMoveCount");
        AssignCommand(oRider,ClearAllActions(TRUE));
        AssignCommand(oRider,JumpToLocation(lRider));
        SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_ANIMATE);
        DelayCommand(0.1*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,TRUE,nHorseTail,DLA_MOUNT_STATE_ANIMATE));

    } // in position

} // DLA_State_Move()



void DLA_State_Animate(object oRider,object oHorse,int nHorseTail)
{ // PURPOSE: To animate mounting

    effect eGhost=EffectCutsceneGhost();
    effect eInvis=EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    location lLoc=GetLocation(oHorse);

    DLA_MountDebug("DLA_State_Animate("+GetName(oRider)+","+GetName(oHorse)+","+IntToString(nHorseTail)+")");

    AssignCommand(oRider,ClearAllActions(TRUE));
    //DelayCommand(3.4,SetCreatureAppearanceType(oRider,GetLocalInt(oRider,"nDLAMountedAppearance")));
    //DelayCommand(3.7,SetPhenoType(GetLocalInt(oRider,"nDLAAltPheno"),oRider));
    //DelayCommand(4.1,SetPhenoType(GetLocalInt(oRider,"nDLAMountedPheno"),oRider));
    AssignCommand(oRider,ActionPlayAnimation(ANIMATION_DLA_LOOPING_MOUNT,1.0,5.7*DLA_GetMountTimingMultiple()));
    DelayCommand(3.6*DLA_GetMountTimingMultiple(),SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_APPEAR));
    //DelayCommand(4.11,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oHorse,4.0));
    //DelayCommand(4.19,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oHorse,4.0));
    //DelayCommand(4.12,AssignCommand(oRider,ClearAllActions(TRUE)));
    //DelayCommand(4.13,AssignCommand(oRider,JumpToLocation(lLoc)));
    //DelayCommand(4.14,AssignCommand(oRider,SetFacing(GetFacing(oHorse))));
    //DelayCommand(4.15,AssignCommand(oRider,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM6,1.0,2.0)));
    DelayCommand(4.2*DLA_GetMountTimingMultiple(),DLA_Mount(oRider,oHorse,TRUE,nHorseTail,DLA_MOUNT_STATE_APPEAR));

} // DLA_State_Animate()



void DLA_State_Appear(object oRider,object oHorse,int nHorseTail)
{ // PURPOSE: Change the PC to the proper appearance

    int nPheno=GetLocalInt(oRider,"nDLAMountedPheno");
    int nApp=GetLocalInt(oRider,"nDLAMountedAppearance");
    int nTail=nHorseTail;

    DLA_MountDebug("DLA_State_Appear("+GetName(oRider)+","+GetName(oHorse)+","+IntToString(nHorseTail)+")");

    if (nTail==DLA_HORSE_TAIL_AUTOMATIC||nTail==0)
    { // determine tail

        nTail=DLA_GetMountedHorseType(oHorse);

    } // determine tail

    if (GetCreatureTailType(oRider)!=nTail||GetPhenoType(oRider)!=nPheno||GetAppearanceType(oRider)!=nApp)
    { // switch
        SetCreatureAppearanceType(oRider,nApp);
        SetPhenoType(nPheno,oRider);
        SetCreatureTailType(nTail,oRider);
        DelayCommand(0.33*DLA_GetMountTimingMultiple(),DLA_State_Appear(oRider,oHorse,nTail));
    } // switch
    else
    { // appear done

        DLA_MountDebug("   APPEAR DONE");
        SetLocalInt(oRider,"nDLAMountState",DLA_MOUNT_STATE_COMPLETE);
        DelayCommand(0.03,DLA_Mount(oRider,oHorse,TRUE,nHorseTail,DLA_MOUNT_STATE_COMPLETE));
        //AssignCommand(GetModule(),DelayCommand(1.0,DLA_Horse_VerifyValidMounted(oRider)));

    } // appear done

} // DLA_State_Appear()



int DLA_GetMountedHorseType(object oHorse)
{
    int nApp=GetAppearanceType(oHorse);

    DLA_MountDebug("  DLA_GetMountedHorseType("+GetName(oHorse)+") nAppearance="+IntToString(nApp));

    if (nApp>486&&nApp<552)
    { // appearance
        return (nApp-486+3);
    } // appearance
    else if (nApp>559&&nApp<567)
    { // tail
       return GetCreatureTailType(oHorse);
    } // tail

    return APPEARANCE_TYPE_INVALID;
} // DLA_GetMountedHorseType()



void DLA_State_Complete(object oRider,object oHorse)
{ // PURPOSE: Final part of the mounting process

    object oWP=GetWaypointByTag(DLA_UNMOUNTED_MOUNT_MOVE);
    effect eDisarmTrap = SupernaturalEffect(EffectSkillDecrease(SKILL_DISABLE_TRAP , 50));
    effect eOpenLock   = SupernaturalEffect(EffectSkillDecrease(SKILL_OPEN_LOCK    , 50));
    effect eHide       = SupernaturalEffect(EffectSkillDecrease(SKILL_HIDE         , 50));
    effect eMove       = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY, 50));
    effect ePickPocket = SupernaturalEffect(EffectSkillDecrease(SKILL_PICK_POCKET  , 50));
    effect eSetTrap    = SupernaturalEffect(EffectSkillDecrease(SKILL_SET_TRAP     , 50));
    effect eTumble     = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE       , 50));

    DLA_MountDebug("DLA_State_Complete("+GetName(oRider)+","+GetName(oHorse)+")");

    if (GetArea(oWP)!=GetArea(oHorse)&&GetIsObjectValid(oHorse))
    { // despawn the horse

        SetCommandable(TRUE,oHorse);
        SetAILevel(oHorse,AI_LEVEL_DEFAULT);
        SetLocalString(oRider,"sHorseTag",GetTag(oHorse));
        DLA_StoreHorse(oHorse);
        DelayCommand(2.0*DLA_GetMountTimingMultiple(),DLA_State_Complete(oRider,oHorse));

    } // despawn the horse
    else
    { // end

        DLA_MountDebug(GetName(oRider)+" successfully mounted.","060");
        DLA_RefreshMovementSpeed(oRider);
        SetFootstepType(FOOTSTEP_TYPE_DLA_HORSE, oRider);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDisarmTrap,oRider);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,eOpenLock,oRider);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,eHide,oRider);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,eMove,oRider);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePickPocket,oRider);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSetTrap,oRider);
        //ApplyEffectToObject(DURATION_TYPE_PERMANENT,eTumble,oRider);
        SetAILevel(oRider,AI_LEVEL_DEFAULT);
        DeleteLocalInt(oRider,"nDLAMountState");
        if (GetLocalInt(oRider,"bMountEndCutscene")) DelayCommand(2.0,SetCutsceneMode(oRider,FALSE));
        DeleteLocalInt(oRider,"bHorseActionActive");
        //AssignCommand(GetModule(),DelayCommand(3.0,DLA_Horse_VerifyValidMounted(oRider)));

    } // end

} // DLA_State_Complete()


void privateDLA_HandleLacHorse(object oHorse)
{ // PURPOSE: To preserve items in packs on LacHorse and then
  // destroy it

    object oRider=GetLocalObject(oHorse,"oDLAMyMaster");

    DLA_Horse_TransferEquipment(oHorse,oRider);
    if (GetIsObjectValid(GetMaster(oHorse))) RemoveHenchman(GetMaster(oHorse),oHorse);
    AssignCommand(oHorse,SetIsDestroyable(TRUE,FALSE,FALSE));
    DelayCommand(5.0,DestroyObject(oHorse));

} // privateDLA_HandleLacHorse()


void DLA_StoreHorse(object oHorse)
{ // PURPOSE: To move the horse, reduce its AI, and make not commandable

    object oWP=GetWaypointByTag(DLA_UNMOUNTED_MOUNT_MOVE);

    if (GetTag(oHorse)=="LacHorse"||GetTag(oHorse)=="")
    { // deal with storing lachorse
        privateDLA_HandleLacHorse(oHorse);
        return;
    } // deal with storing lachorse
    else
    { // not Lacinda's horse

        DLA_MountDebug("DLA_StoreHorse("+GetName(oHorse)+")");

        if (GetIsObjectValid(oWP))
        { // waypoint exists

            if (GetArea(oWP)!=GetArea(oHorse))
            { // move horse

                AssignCommand(oHorse,ClearAllActions(TRUE));
                AssignCommand(oHorse,JumpToObject(oWP));
                DelayCommand(0.5*DLA_GetMountTimingMultiple(),DLA_StoreHorse(oHorse));

            } // move horse
            else
            { // arrived

                DLA_MountDebug("     Stored.");

                DeleteLocalInt(oHorse,"bBeingMounted");
                SetLocalInt(oHorse,"bStored",TRUE);
                AssignCommand(oHorse,ClearAllActions(TRUE));
                SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHorse);
                SetAILevel(oHorse,AI_LEVEL_LOW);
                SetCommandable(FALSE,oHorse);
                if (GetIsObjectValid(GetMaster(oHorse))) RemoveHenchman(GetMaster(oHorse),oHorse);

            } // arrived

        } // waypoint exists
        else
        { // error
            DLA_MountDebug("ERROR IN HORSE SETUP: A waypoint tagged "+DLA_UNMOUNTED_MOUNT_MOVE+" must be setup in a safe out of the way area where PCs do not go.");
        } // error

     } // not Lacinda's horse

} // DLA_StoreHorse()

void DLA_RetrieveHorse(object oHorse,location lLoc)
{ // PURPOSE: To set to commandable, set AI back to default, and move to mounting
  // PC or NPC

  object oMaster=GetLocalObject(oHorse,"oDLAMyMaster");


  DLA_MountDebug("DLA_RetrieveHorse("+GetName(oHorse)+")");

  if (GetIsObjectValid(oHorse))
  { // horse is valid

      SetCommandable(TRUE,oHorse);
      SetAILevel(oHorse,AI_LEVEL_DEFAULT);
      //if (GetIsObjectValid(oMaster))
      //  AddHenchman(oMaster,oHorse);
      DelayCommand(0.1*DLA_GetMountTimingMultiple(),AssignCommand(oHorse,ClearAllActions(TRUE)));
      DelayCommand(0.11*DLA_GetMountTimingMultiple(),AssignCommand(oHorse,JumpToLocation(lLoc)));
      SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oHorse);
      DeleteLocalInt(oHorse,"bStored");

  } // horse is valid


} // DLA_RetrieveHorse()



float DLA_GetMountTimingMultiple()
{ // PURPOSE: To return the multiple used for mount timing

    float fRet=1.0;

    if (!GetLocalInt(GetModule(),"bDefaultMountingEnabled"))
    { // go ahead and get the multiple

         fRet=GetLocalFloat(GetModule(),"fMountTimingMultiple");
         if (fRet<=0.0) fRet=1.0;

    } // go ahead and get the multiple

    return fRet;

} // DLA_GetMountTimingMultiple()


int privateDLA_GetIsValidAppearanceType(object oCreature)
{ // PURPOSE: Returns TRUE if oCreature is an acceptable appearance type
  // Scripted By: Deva B. Winblood 8/02/2006

    int nApp=GetAppearanceType(oCreature);
    int bValid=TRUE;

    if (nApp>779||nApp<0) bValid=FALSE;
    else if (nApp>459&&nApp<467) bValid=FALSE;
    else if (nApp>342&&nApp<350) bValid=FALSE;

    if (!bValid) PrintString(GetName(oCreature)+" Transition Appearance Error: Appearance = "+IntToString(nApp));

    return bValid;
} // privateDLA_GetIsValidAppearanceType()


void privateDLA_RepairAppearance(object oCreature)
{ // PURPOSE: Returns the creature to a valid appearance

    int nRT=GetRacialType(oCreature);
    int nAP;

    if (nRT==RACIAL_TYPE_DWARF) nAP=0;
    else if (nRT==RACIAL_TYPE_ELF) nAP=1;
    else if (nRT==RACIAL_TYPE_GNOME) nAP=2;
    else if (nRT==RACIAL_TYPE_HALFLING) nAP=3;
    else if (nRT==RACIAL_TYPE_HALFELF) nAP=4;
    else if (nRT==RACIAL_TYPE_HALFORC) nAP=5;
    else { nAP=6; }

    SetCreatureAppearanceType(oCreature,nAP);
    PrintString(GetName(oCreature)+" Appearance Fix attempt to change to:"+IntToString(nAP));

} // privateDLA_RepairAppearance()


void privateDLA_CreateHitchMapNote(object oHorse,object oPost)
{ // PURPOSE: Make sure there is a map note for the hitched horse
  // Scripted By: Deva B. Winblood 8/02/2006

    int nID;
    object oNote;

    nID=GetLocalInt(oHorse,"nID");
    if (nID==0)
    { // assign horse unique ID - used to handle removing mapnotes later
        nID=DLA_GetHorseID();
        SetLocalObject(GetModule(),"oHorse_Instance_"+IntToString(nID),oHorse);
        SetLocalInt(oHorse,"nID",nID);
    } // assign horse unique ID - used to handle removing mapnotes later
    oNote=CreateObject(OBJECT_TYPE_WAYPOINT,"dla_wp_horset002",GetLocation(oPost));
    SetLocalObject(oHorse,"dla_hitch",oNote);
    SetLocalObject(GetModule(),"oTied_Horse_Mapnote_"+IntToString(nID),oNote);

} // privatDLA_CreateHitchMapNote()


void privateDLA_JumpHitch(object oHorse,object oPost)
{ // PURPOSE: Make sure the jump happens
  // Scripted By: Deva B. Winblood 8/02/2006

    vector vDir=GetPosition(oPost);
    effect eGhost=EffectCutsceneGhost();

    if (GetArea(oPost)!=GetArea(oHorse)||GetDistanceBetween(oHorse,oPost)>3.0)
    { // jump
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oHorse,2.0);
        AssignCommand(oHorse,ClearAllActions(TRUE));
        AssignCommand(oHorse,JumpToObject(oPost));
        DelayCommand(1.0,privateDLA_JumpHitch(oHorse,oPost));
    } // jump
    else
    { // arrived
        AssignCommand(oHorse,SetFacingPoint(vDir));
        AssignCommand(oHorse,SetAssociateStartLocation());
        AssignCommand(oHorse,SetRespawnLocation());
        DLA_SetIsTied(oHorse);
        DelayCommand(1.0,privateDLA_CreateHitchMapNote(oHorse,oPost));
    } // arrived


} // privateDLA_JumpHitch()


void privateDLA_HitchHorse(object oHorse,object oHitch)
{ // PURPOSE: Used by DLA_NoHorseTransition to hitch a horse
  // Scripted By: Deva B. Winblood  8/02/2006

    object oPost=oHitch;

    if (!GetIsObjectValid(oPost)) oPost=GetNearestObjectByTag(DLA_TAG_HITCHING_POST);

    SetAILevel(oHorse,AI_LEVEL_NORMAL);
    SetCommandable(TRUE,oHorse);
    AssignCommand(oHorse,ClearAllActions(TRUE));
    AssignCommand(oHorse,privateDLA_JumpHitch(oHorse,oPost));

} // privateDLA_HitchHorse()


void privateDLA_CheckAllAppearances(object oPC)
{ // PURPOSE: Make sure once again that all PCs and henchmen have a proper appearance
  // Scripted By: Deva B. Winblood 8/02/2006

    object oHench;
    int nN=1;
    int bRedo=FALSE;

    if (!privateDLA_GetIsValidAppearanceType(oPC))
    { // correct
        privateDLA_RepairAppearance(oPC);
        bRedo=TRUE;
    } // correct
    oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    while(GetIsObjectValid(oHench))
    { // check all henchmen
        if (!privateDLA_GetIsValidAppearanceType(oHench))
        { // correct
            privateDLA_RepairAppearance(oHench);
            bRedo=TRUE;
        } // correct
        nN++;
        oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    } // check all henchmen

    if (bRedo) DelayCommand(3.0,privateDLA_CheckAllAppearances(oPC));
} // privateDLA_CheckAllAppearances()


void DLA_NoHorseTransition(object oPC,object oDestination,int bAnimate=TRUE,int bHitch=TRUE,object oPost=OBJECT_INVALID,int nState=0,int bAnnounced=FALSE)
{ // PURPOSE: Deal with horses before transitioning
  // Scripted By: Deva B. Winblood  8/02/2006
    int nNextState=nState;
    object oHench;
    int nN;
    int bStay=FALSE;
    int bWarned=bAnnounced;
    int nL;
    object oSubHench;

    if (nState==0)
    { // initial state
        if (DLA_GetIsMounted(oPC)&&!GetLocalInt(oPC,"bDismounting"))
        { // PC is mounted
            SetLocalInt(oPC,"bGoingInside",TRUE);
            DelayCommand(18.0,DeleteLocalInt(oPC,"bGoingInside"));
            DLA_Dismount(oPC,bAnimate,FALSE,bHitch);
            if (bHitch&&!bWarned)
            {
              FloatingTextStringOnCreature("Horses are now tied to nearby hitching post",oPC,FALSE);
              bWarned=TRUE;
            }
            SetLocalInt(oPC,"bDismounting",TRUE);
            bStay=TRUE;
        } // PC is mounted
        else
        { // check henchmen
            nN=1;
            oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
            while(GetIsObjectValid(oHench))
            { // check for mounted henchmen
                if (DLA_GetIsMounted(oHench)&&!GetLocalInt(oHench,"bDismounting"))
                { // henchman is mounted
                    if (bHitch&&!bWarned)
                    {
                      FloatingTextStringOnCreature("Horses are now tied to nearby hitching post", oPC, FALSE);
                      bWarned=TRUE;
                    }
                    SetLocalInt(oHench,"bGoingInside",TRUE);
                    DelayCommand(18.0,DeleteLocalInt(oHench,"bGoingInside"));
                    DLA_Dismount(oHench,bAnimate,FALSE,bHitch);
                    bStay=TRUE;
                    //SetLocalInt(oPC,"bDismounting",TRUE);
                    SetLocalInt(oHench,"bDismounting",TRUE);
                } // henchman is mounted
                nN++;
                oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
            } // check for mounted henchmen
        } // check henchmen
        if (!bStay) nNextState=1;
        DelayCommand(1.5,DLA_NoHorseTransition(oPC,oDestination,bAnimate,bHitch,oPost,nNextState,bWarned));
    } // initial state
    else if (nState==1)
    { // no one is mounted deal with horses
        nN=1;
        oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
        while(GetIsObjectValid(oHench))
        { // check for horses that are not mounted
            if (DLA_GetIsDLAHorse(oHench))
            { // it is a horse
                DLA_RemoveHenchman(GetMaster(oHench),oHench,TRUE);
                if (bHitch)
                {
                   privateDLA_HitchHorse(oHench,oPost);
                   if (!bWarned) FloatingTextStringOnCreature("Horses are now tied to nearby hitching post", oPC, FALSE);
                   bWarned=TRUE;
                }
                bStay=TRUE;
            } // it is a horse
            else
            { // check henchmen for sub-henchmen horses
                nL=1;
                oSubHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oHench,nL);
                while(GetIsObjectValid(oSubHench))
                { // check sub-henchmen
                    if (DLA_GetIsDLAHorse(oSubHench))
                    { // is a horse
                        DLA_RemoveHenchman(GetMaster(oSubHench),oSubHench,TRUE);
                        if (bHitch)
                        { // hitch
                            privateDLA_HitchHorse(oSubHench,oPost);
                            if (!bWarned) FloatingTextStringOnCreature("Horses are now tied to nearby hitching post", oPC, FALSE);
                            bWarned=TRUE;
                        } // hitch
                        bStay=TRUE;
                    } // is a horse
                    nL++;
                    oSubHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oHench,nL);
                } // check sub-henchmen
            } // check henchmen for sub-henchmen horses
            nN++;
            oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
        } // check for horses that are not mounted
        if (!bStay) nNextState=2;
        DelayCommand(0.5,DLA_NoHorseTransition(oPC,oDestination,bAnimate,bHitch,oPost,nNextState));
    } // no one is mounted deal with horses
    else if (nState==2)
    { // verify no illegal appearances
        if (!privateDLA_GetIsValidAppearanceType(oPC))
        { // correct PC appearance
            privateDLA_RepairAppearance(oPC);
            bStay=TRUE;
        } // correct PC appearance
        nN=1;
        oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
        while(GetIsObjectValid(oHench))
        { // list henchmen appearance types
            if (!privateDLA_GetIsValidAppearanceType(oHench))
            { // correct henchman appearance
                privateDLA_RepairAppearance(oHench);
                bStay=TRUE;
            } // correct henchman appearance
            nN++;
            oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
        } // list henchmen appearance types

        if (!bStay) nNextState=3;
        DelayCommand(1.5,DLA_NoHorseTransition(oPC,oDestination,bAnimate,bHitch,oPost,nNextState));
    } // verify no illegal appearances
    else if (nState==3)
    { // all horses dealt with - transition
        if (GetIsObjectValid(oDestination))
        { //
            AssignCommand(oPC,ClearAllActions(TRUE));
            AssignCommand(oPC,JumpToObject(oDestination));
            AssignCommand(oPC,DLA_SetAreaTransCameraFacing(oPC,oDestination));
        } //
        DelayCommand(4.0,privateDLA_CheckAllAppearances(oPC));
    } // all horses dealt with - transition

} // DLA_NoHorseTransition()



//void main(){}
