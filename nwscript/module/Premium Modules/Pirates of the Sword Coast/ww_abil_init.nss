//::///////////////////////////////////////////////
//:: Witch Wake: Ability Check (Default Initialization Script)
//:: WW_Abil_Init.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Initializes the default variables for the
     WW Ability Check system. This can be run on
     the NPC in question at any point prior to
     the player encountering the Ability Check
     system in conversation.

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* that is
                  being initialized.
     bTrackResultPerCreature = TRUE means each
                               person determines
                               their own success
                               or failure. FALSE
                               means that everyone
                               shares the same
                               results.
     bAllowRetries = TRUE means the check can be
                     made multiple times. FALSE
                     means that it can only be
                     made once.
     iDCIncreaseOnFailure = The DC increases by
                            this amount on every
                            failure. Set it to 0
                            if you don't want it
                            to increase.
     bTrackDCPerCreature = TRUE means that the DC
                           increase is tracked per
                           player. FALSE means it
                           is shared by everybody.
     bAutoDC = TRUE means that any DC variables
               are overridden by the player's
               HitDice+10+iAutoDCModifier. FALSE
               means that the DC must manually set
               using WW_SetBaseAbilityDC().
     iAutoDCModifier = Positive numbers make the
                       AutoDC system more difficult.
                       Negative numbers make it
                       easier.

*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 13, 2002
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    //Edit these on a per NPC basis if you wish
    //to change the default values.
    string sCheckType = "WW_CHECK_TYPE_ALL";
    int bTrackResultPerCreature = TRUE;
    int bAllowRetries = TRUE;
    int iDCIncreaseOnFailure = 5;
    int bTrackDCPerCreature = TRUE;
    int bAutoDC = TRUE;
    int iAutoDCModifier = 0;

    //Initialize the system using the above variables.
    WW_InitializeAbility(sCheckType,
                         bTrackResultPerCreature,
                         bAllowRetries,
                         iDCIncreaseOnFailure,
                         bTrackDCPerCreature,
                         bAutoDC,
                         iAutoDCModifier);
}
