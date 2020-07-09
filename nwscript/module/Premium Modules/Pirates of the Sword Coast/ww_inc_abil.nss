//::///////////////////////////////////////////////
//:: Witch Wake: Include File (Ability Check System)
//:: WW_Inc_Abil.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Contains the functions for handling all
     ability checks in "The Witch's Wake."
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: January 8, 2003
//:://////////////////////////////////////////////

//:://////////////////////////////////////////////
//:: Declare WW_ABILITY_* Constants
//:://////////////////////////////////////////////
/**///Ability Scores...
/**/const int WW_ABILITY_DEXTERITY        = 1;
/**/const int WW_ABILITY_STRENGTH         = 2;
/**/const int WW_ABILITY_WISDOM           = 3;
/**/const int WW_ABILITY_INTELLIGENCE     = 4;
/**/
/**///Spells...
/**/const int WW_ABILITY_CHARM_PERSON     = 10;
/**/const int WW_ABILITY_CONFUSION        = 11;
/**/const int WW_ABILITY_HOLD_PERSON      = 12;
/**/const int WW_ABILITY_REMOVE_FEAR      = 13;
/**/const int WW_ABILITY_SCARE            = 14;
/**/const int WW_ABILITY_SILENCE          = 15;
/**/const int WW_ABILITY_FEEBLEMIND       = 16;
/**/const int WW_ABILITY_MIND_FOG         = 17;
/**/const int WW_ABILITY_BEWILDERMENT     = 18;
/**/const int WW_ABILITY_DOMINATE_PERSON  = 19;
/**/const int WW_ABILITY_FEAR             = 20;
/**/const int WW_ABILITY_BESTOW_CURSE     = 21;
/**/const int WW_ABILITY_BLESS            = 22;
/**/const int WW_ABILITY_PRAYER           = 23;
/**/const int WW_ABILITY_WOUNDING_WHISPERS= 24;
/**/
/**///Skills...
/**/const int WW_ABILITY_ANIMAL_EMPATHY   = 100;
/**/const int WW_ABILITY_LORE             = 101;
/**/const int WW_ABILITY_PERFORM          = 102;
/**/const int WW_ABILITY_PERSUADE         = 103;
/**/const int WW_ABILITY_SEARCH           = 104;
/**/const int WW_ABILITY_TAUNT            = 105;
/**/const int WW_ABILITY_USE_MAGIC_DEVICE = 106;
/**/const int WW_ABILITY_BLUFF            = 107;
/**/const int WW_ABILITY_INTIMIDATE       = 108;
/**/
/**///Feats...
/**/const int WW_ABILITY_RAGE             = 200;
/**/const int WW_ABILITY_STUNNING_FIST    = 201;
/**/const int WW_ABILITY_DIVINE_WRATH     = 202;
/**/const int WW_ABILITY_BARD_SONG        = 203;
/**/const int WW_ABILITY_LAY_HANDS        = 204;
/**/const int WW_ABILITY_DIRTY_FIGHTING   = 205;
/**/
/**///Miscellaneous...
/**/const int WW_ABILITY_FLIRT            = 300;
/**/const int WW_ABILITY_KINSHIP          = 301;


//:://////////////////////////////////////////////
//:: Declare WW_CHECK_TYPE_* Constants
//:://////////////////////////////////////////////
/**/const int WW_CHECK_TYPE_ALL          = 0;
/**/const int WW_CHECK_TYPE_BLUFF        = 1;
/**/const int WW_CHECK_TYPE_INTIMIDATE   = 2;
/**/const int WW_CHECK_TYPE_OBTAIN_FAVOR = 3;
/**/const int WW_CHECK_TYPE_PACIFY       = 4;
/**/const int WW_CHECK_TYPE_PROVOKE      = 5;
/**/const int WW_CHECK_TYPE_SILENCE      = 6;
/**/const int WW_CHECK_TYPE_CONFUSE      = 7;
/**/const int WW_CHECK_TYPE_MISC_1       = 100;
/**/const int WW_CHECK_TYPE_MISC_2       = 101;


//:://////////////////////////////////////////////
//:: Declare WW_CONSEQUENCE_* Constants
//:://////////////////////////////////////////////
/**/const int WW_CONSEQUENCE_ALARM    = 0;
/**/const int WW_CONSEQUENCE_CLIMB    = 1;
/**/const int WW_CONSEQUENCE_KILL     = 2;
/**/const int WW_CONSEQUENCE_PARALYZE = 3;
/**/const int WW_CONSEQUENCE_SILENCE  = 4;


//:://////////////////////////////////////////////
//:: Declare all of the Functions
//:://////////////////////////////////////////////
/**///CORE FUNCTIONS...
/**/string WW_GetCreatureID           (object oCreature);
/**/int WW_GetAbortedResultValue      (string sCheckType = "WW_CHECK_TYPE_ALL",
/**/                                   object oCreature = OBJECT_INVALID);
/**/int WW_GetIsResultTrackedPerCreature (string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetIsRetryAllowed          (string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetDCIncreaseOnFailure     (string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetIsDCTrackedPerCreature  (string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetIsAutoDCActive          (string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetAutoDCModifier          (string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetDCModifier              (object oCreature = OBJECT_INVALID,
/**/                                   string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_CheckIntelligence          (object oCreature,
/**/                                   int    bSmartLine = FALSE,
/**/                                   int    bStupidLine = FALSE);
/**/int WW_CastSpellInConversation    (object oCaster,
/**/                                   int    iSpell,
/**/                                   int    iAbilityType,
/**/                                   object oTarget = OBJECT_SELF);
/**/void WW_UseRageInConversation     (object oCreature);
/**/void WW_SetLocalIntForCheckTypes  (int    iValue,
/**/                                   string sPrefix,
/**/                                   string sCheckType = "WW_CHECK_TYPE_ALL",
/**/                                   object oCreature = OBJECT_INVALID);
/**///SHELL FUNCTIONS
/**/void WW_InitializeAbility         (string sCheckType = "WW_CHECK_TYPE_ALL",
/**/                                   int    bTrackResultPerCreature = TRUE,
/**/                                   int    bAllowRetries = TRUE,
/**/                                   int    iDCIncreaseOnFailure = TRUE,
/**/                                   int    bTrackDCPerCreature = TRUE,
/**/                                   int    bAutoDC = TRUE,
/**/                                   int    iAutoDCModifier = 0);
/**/void WW_SetBaseAbilityDC          (int    iBaseAbilityDC,
/**/                                   object oCreature,
/**/                                   string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetShouldDisplayAbility    (string sAbility,
/**/                                   object oCreature,
/**/                                   int    bSmartLine = FALSE,
/**/                                   int    bStupidLine = FALSE);
/**/int WW_GetHasAbility              (string sAbility,
/**/                                   object oCreature);
/**/int WW_DoAbilityCheck             (string sAbility,
/**/                                   object oCreature,
/**/                                   string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetAbilityCheckSuccess     (object oCreature = OBJECT_INVALID,
/**/                                   string sCheckType = "WW_CHECK_TYPE_ALL");
/**/int WW_GetAbilityCheckFailed      (object oCreature = OBJECT_INVALID,
/**/                                   string sCheckType = "WW_CHECK_TYPE_ALL");
/**/void WW_DoAbilityConsequences     (string sConsequence,
/**/                                   object oCreature);


//:://////////////////////////////////////////////
//:: WW_GetCreatureID()
//:: RETURN TYPE: String
//:://////////////////////////////////////////////
/*
     Returns a relatively unique ID string for the
     Creature.

  VARIABLE LIST:
     oCreature = The creature whose ID is being
                 defined.
*/
//:://////////////////////////////////////////////
string WW_GetCreatureID(object oCreature)
{
    //Return "" in the case of an invalid creature.
    int bValidCreature = GetIsObjectValid(oCreature);
    if (bValidCreature == FALSE)
    {
        return "";
    }

    int bCreatureIsPC = GetIsPC(oCreature);
    string sName = GetName(oCreature);
    string sTag;

    //If the creature is a PC...
    if (bCreatureIsPC)
    {
        //Use their Player Name in place of a tag.
        sTag = GetPCPlayerName(oCreature);
    }
    //Otherwise...
    else
    {
        //Use the tag.
        sTag = GetTag(oCreature);
    }

    //Compile the Creature ID and return it.
    string sCreatureID = sTag+sName;
    return sCreatureID;
}
//END string WW_GetCreatureID()


//:://////////////////////////////////////////////
//:: WW_GetAbortedResultValue()
//:: RETURN TYPE: Integer
//:://////////////////////////////////////////////
/*
     Returns the value saved out on an aborted
     Ability Check.
        -3 = Unknown Ability error
        -2 = oCreature didn't have the Ability
        -1 = Illegal Retry

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
     oCreature = The creature being referenced
                 for creature-specific results.
                 OBJECT_INVALID will cause it to
                 return the generic value.
*/
//:://////////////////////////////////////////////
int WW_GetAbortedResultValue (string sCheckType = "WW_CHECK_TYPE_ALL",
                             object oCreature = OBJECT_INVALID)
{
    int iAbortedResultValue;

    //If a valid creature has been passed in...
    //if (oCreature != OBJECT_INVALID)
    if(GetIsObjectValid(oCreature))
    {
        //Use the Creature's ID to find the per creature Abort Value
        string sCreatureID = WW_GetCreatureID(oCreature);
        iAbortedResultValue = GetLocalInt(OBJECT_SELF, "iAbilityResultAborted"+sCheckType+sCreatureID);
    }
    //Otherwise just get the generic Abort Value
    else
    {
        iAbortedResultValue = GetLocalInt(OBJECT_SELF, "iAbilityResultAborted"+sCheckType);
    }

    //Return the Abort Value
    return iAbortedResultValue;

}
//END int WW_GetAbortedResultValue()


//:://////////////////////////////////////////////
//:: WW_GetIsResultTrackedPerCreature()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if results for the given Check
     Type is being tracked per creature.

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetIsResultTrackedPerCreature (string sCheckType = "WW_CHECK_TYPE_ALL")
{
    return GetLocalInt(OBJECT_SELF, "bTrackResultPerCreature"+sCheckType);
}
//END int WW_GetIsResultTrackedPerCreature()


//:://////////////////////////////////////////////
//:: WW_GetIsRetryAllowed()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if retries are being allowed
     for the given Check Type.

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetIsRetryAllowed (string sCheckType = "WW_CHECK_TYPE_ALL")
{
    return GetLocalInt(OBJECT_SELF, "bAllowRetries"+sCheckType);
}
//END int WW_GetIsRetryAllowed()


//:://////////////////////////////////////////////
//:: WW_GetDCIncreaseOnFailure()
//:: RETURN TYPE: Integer
//:://////////////////////////////////////////////
/*
     Returns the modifier that the DC for the given
     Check Type increases on Failure.

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetDCIncreaseOnFailure (string sCheckType = "WW_CHECK_TYPE_ALL")
{
    return GetLocalInt(OBJECT_SELF, "iDCIncreaseOnFailure"+sCheckType);
}
//END int WW_GetDCIncreaseOnFailure()


//:://////////////////////////////////////////////
//:: WW_GetIsDCTrackedPerCreature()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if the DC increase for the given
     Check Type is being tracked per creature.

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetIsDCTrackedPerCreature (string sCheckType = "WW_CHECK_TYPE_ALL")
{
    return GetLocalInt(OBJECT_SELF, "bTrackDCPerCreature"+sCheckType);
}
//END int WW_GetIsDCTrackedPerCreature()


//:://////////////////////////////////////////////
//:: WW_GetIsAutoDCActive()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if the Auto-DC system has been
     activated for the given Check Type.

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetIsAutoDCActive (string sCheckType = "WW_CHECK_TYPE_ALL")
{
    return GetLocalInt(OBJECT_SELF, "bAutoDC"+sCheckType);
}
//END int WW_GetIsAutoDCActive()


//:://////////////////////////////////////////////
//:: WW_GetAutoDCModifier()
//:: RETURN TYPE: Integer
//:://////////////////////////////////////////////
/*
     Returns the DC modifier that's applied on
     failure for the given Check Type.

  VARIABLE LIST:
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetAutoDCModifier (string sCheckType = "WW_CHECK_TYPE_ALL")
{
    return GetLocalInt(OBJECT_SELF, "iAutoDCModifier"+sCheckType);
}
//END int WW_GetAutoDCModifier()


//:://////////////////////////////////////////////
//:: WW_GetDCModifier()
//:: RETURN TYPE: Integer
//:://////////////////////////////////////////////
/*
     Returns the DC Modifier.

  VARIABLE LIST:
     oCreature = The creature whose DC Modifier is
                 being referenced. OBJECT_INVALID
                 will cause it to look up the
                 generic DC modifier.
     sCheckType = The WW_CHECK_TYPE_* that the DC
                  applies to.
*/
//:://////////////////////////////////////////////
int WW_GetDCModifier (object oCreature = OBJECT_INVALID,
                      string sCheckType = "WW_CHECK_TYPE_ALL")
{
    int iDCModifier;

    //If a valid creature has been passed in...
    //if (oCreature != OBJECT_INVALID)
    if(GetIsObjectValid(oCreature))
    {
        //Use the Creature's ID to find the per creature DC Modifier
        string sCreatureID = WW_GetCreatureID(oCreature);
        iDCModifier = GetLocalInt(OBJECT_SELF, "sDCModifier"+sCheckType+sCreatureID);
    }
    //Otherwise just get the generic DC modifier
    else
    {
        iDCModifier = GetLocalInt(OBJECT_SELF, "sDCModifier"+sCheckType);
    }

    //Return the DCModifier
    return iDCModifier;
}
//END int WW_GetDCModifier()


//:://////////////////////////////////////////////
//:: WW_CheckIntelligence()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if the creature's intelligence
     is in the low range

  VARIABLE LIST:
     oCreature = The creature whose Intelligence
                 is being checked.
     bSmartLine = TRUE means the function will
                  only return TRUE if the player
                  is of Normal intelligence. FALSE
                  disables this check.
     bStupidLine = TRUE means the function will
                   only return TRUE if the player
                   is of Low intelligence. FALSE
                   disables this check.
*/
//:://////////////////////////////////////////////
int WW_CheckIntelligence(object oCreature, int bSmartLine = FALSE,
                         int bStupidLine = FALSE)
{
    int iIntelligence = GetAbilityScore(oCreature, ABILITY_INTELLIGENCE);

    //Handle Smart lines.
    if (bSmartLine)
    {
        if (iIntelligence >= 9)
        {
            return TRUE;
        }
        return FALSE;
    }
    //Handle Stupid lines.
    if (bStupidLine)
    {
        if (iIntelligence < 9)
        {
            return TRUE;
        }
        return FALSE;
    }
    //Or just return TRUE if it isn't a Smart or Stupid check
    return TRUE;
}


//:://////////////////////////////////////////////
//:: WW_CastSpellInConversation()
//:: RETURN TYPE: Integer
//:://////////////////////////////////////////////
/*
     Casts a fake version of the designated spell
     without breaking out of conversation.

     Returns the Ability Modifier for use in
     calculating the Check Value in WW's Ability
     Check system.

  VARIABLE LIST:
     oCaster = The creature casting the spell.
     iSpell = The SPELL_* constant being cast.
     iAbilityType = The ABILITY_* constant used
                    to determine the casting
                    modifier.
     oTarget = The creature the spell is being
               cast at.
*/
//:://////////////////////////////////////////////
int WW_CastSpellInConversation(object oCaster, int iSpell, int iAbilityType,
                               object oTarget = OBJECT_SELF)
{
    //Decrement the spell & cast a fake one
    AssignCommand(oCaster, ActionPauseConversation());
    DecrementRemainingSpellUses(oCaster, iSpell);
    AssignCommand(oCaster, ActionCastFakeSpellAtObject(iSpell, oTarget));
    AssignCommand(oCaster, ActionResumeConversation());

    //Determine the appropriate Ability Modifier
    int iAbilMod = GetAbilityModifier(iAbilityType, oCaster);

    //Return the Ability Modifier
    return iAbilMod;
}
//END int WW_CastSpellInConversation()


//:://////////////////////////////////////////////
//:: WW_UseRageInConversation()
//:: RETURN TYPE: void
//:://////////////////////////////////////////////
/*
     This is copied from 'nw_s1_barbrage' with
     some small modifications to keep it from
     breaking out of conversation and to redefine
     the target as oCreature rather than
     OBJECT_SELF. All of the same stat changes
     apply.

  VARIABLE LIST:
     oCreature = The creature that's raging.
*/
//:://////////////////////////////////////////////
void WW_UseRageInConversation(object oCreature)
{
    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN, oCreature);
    int nIncrease;
    int nSave;
    if (nLevel < 15)
    {
        nIncrease = 4;
        nSave = 2;
    }
    else
    {
        nIncrease = 6;
        nSave = 3;
    }

    //Pause the Conversation.
    AssignCommand(oCreature, ActionPauseConversation());

    //Decrement the Creature's Rage ability & play voice chat.
    DecrementRemainingFeatUses(oCreature, FEAT_BARBARIAN_RAGE);
    AssignCommand(oCreature, PlayVoiceChat(VOICE_CHAT_BATTLECRY1));

    //Determine the duration by getting the con modifier after being modified
    int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION, oCreature) + nIncrease;
    effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nIncrease);
    effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
    effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Link the effects.
    effect eLink = EffectLinkEffects(eCon, eStr);
    eLink = EffectLinkEffects(eLink, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
//CUT//    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));

    //Make effect extraordinary
    eLink = ExtraordinaryEffect(eLink);
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE); //Change to the Rage VFX

    if (nCon > 0)
    {
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCreature, RoundsToSeconds(nCon));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCreature) ;
    }

    //Resume the Conversation.
    AssignCommand(oCreature, ActionResumeConversation());
}
//END void WW_UseRageInConversation()


//:://////////////////////////////////////////////
//:: WW_SetLocalIntForCheckTypes()
//:: RETURN TYPE: Void
//:://////////////////////////////////////////////
/*
     Sets all of the local ints, cloning them
     properly to handle CHECK_TYPE_ALL and the
     possibility that it might be tracking per
     creature.

  VARIABLE LIST:
     iValue = The value that you want the local
              int to be set to.
     sPrefix = The prefix used to identify the
               variable.
     sCheckType = The base Check Type for which
                  value is being set.
     oCreature = The creature being referenced if
                 the value is being tracked per
                 creature. Pass in OBJECT_INVALID
                 if you're not tracking anything
                 by creature.
*/
//:://////////////////////////////////////////////
void WW_SetLocalIntForCheckTypes (int iValue, string sPrefix,
                                  string sCheckType = "WW_CHECK_TYPE_ALL",
                                  object oCreature = OBJECT_INVALID)
{
    int bTrackResultPerCreature = GetIsObjectValid(oCreature);

    //If the Result is being tracked per creature...
    if (bTrackResultPerCreature)
    {
        string sCreatureID = WW_GetCreatureID(oCreature);
        //If the Check Type isn't the generic "ALL"...
        if (sCheckType != "WW_CHECK_TYPE_ALL")
        {
            //Declare the creature-specific value for the specified Prefix &
            //Check Type
            SetLocalInt(OBJECT_SELF, sPrefix+sCheckType+sCreatureID, iValue);
            //And clone it to "ALL"
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_ALL"+sCreatureID, iValue);
        }
        //If the Check Type is the generic "ALL"...
        else
        {
            //Declare the per creature value for the specified Prefix across all
            //Check Types.
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_ALL"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_BLUFF"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_INTIMIDATE"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_OBTAIN_FAVOR"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_PACIFY"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_PROVOKE"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_SILENCE"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_CONFUSE"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_MISC_1"+sCreatureID, iValue);
            SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_MISC_2"+sCreatureID, iValue);
        }
    }
    //Declare the non-creature-specific value regardless.
    //If the Check Type isn't the generic "ALL"
    if (sCheckType != "WW_CHECK_TYPE_ALL")
    {
        //Flag the success specific to this check type
        SetLocalInt(OBJECT_SELF, sPrefix+sCheckType, iValue);
        //And clone it to "ALL"
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_ALL", iValue);
    }
    //If the Check Type is the generic "ALL"
    else
    {
        //Flag success for all Check Types
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_ALL", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_BLUFF", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_INTIMIDATE", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_OBTAIN_FAVOR", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_PACIFY", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_PROVOKE", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_SILENCE", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_CONFUSE", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_MISC_1", iValue);
        SetLocalInt(OBJECT_SELF, sPrefix+"WW_CHECK_TYPE_MISC_2", iValue);
    }
}
//END void WW_SetLocalIntForCheckTypes()


//:://////////////////////////////////////////////
//:: WW_InitializeAbility()
//:: RETURN TYPE: Void
//:://////////////////////////////////////////////
/*
     Initializes OBJECT_SELF to handle the WW
     Ability Check System.

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
void WW_InitializeAbility (string sCheckType = "WW_CHECK_TYPE_ALL",
                           int bTrackResultPerCreature = TRUE,
                           int bAllowRetries = TRUE,
                           int iDCIncreaseOnFailure = 5,
                           int bTrackDCPerCreature = TRUE,
                           int bAutoDC = TRUE,
                           int iAutoDCModifier = 0)
{
    WW_SetLocalIntForCheckTypes(bTrackResultPerCreature, "bTrackResultPerCreature", sCheckType, OBJECT_INVALID);
    WW_SetLocalIntForCheckTypes(bAllowRetries, "bAllowRetries", sCheckType, OBJECT_INVALID);
    WW_SetLocalIntForCheckTypes(iDCIncreaseOnFailure, "iDCIncreaseOnFailure", sCheckType, OBJECT_INVALID);
    WW_SetLocalIntForCheckTypes(bTrackDCPerCreature, "bTrackDCPerCreature", sCheckType, OBJECT_INVALID);
    WW_SetLocalIntForCheckTypes(bAutoDC, "bAutoDC", sCheckType, OBJECT_INVALID);
    WW_SetLocalIntForCheckTypes(iAutoDCModifier, "iAutoDCModifier", sCheckType, OBJECT_INVALID);
}
//END int WW_InitializaAbility()


//:://////////////////////////////////////////////
//:: WW_SetBaseAbilityDC()
//:: RETURN TYPE: Void
//:://////////////////////////////////////////////
/*
     Sets the base Difficulty Class for the coming
     ability check.

     NOTE: The rule of thumb when setting DC's
           within this system is to use the
           player's level+10.

  VARIABLE LIST:
     iBaseAbilityDC = The base DC that will be
                      used for the coming check.
                      The settings in
                      WW_DoAbilityCheck() may
                      apply additional penalties
                      when using this value.
     oCreature = The creature who is making the
                 check.
     sCheckType = The WW_CHECK_TYPE_* that the DC
                  applies to.
*/
//:://////////////////////////////////////////////
void WW_SetBaseAbilityDC(int iBaseAbilityDC, object oCreature,
                         string sCheckType = "WW_CHECK_TYPE_ALL")
{
    int bAutoDC = WW_GetIsAutoDCActive(sCheckType);
    int iAutoDCModifier = WW_GetAutoDCModifier(sCheckType);
    int bTrackingDCPerCreature = WW_GetIsDCTrackedPerCreature(sCheckType);
    int iDCModifier;

    //If the AutoDC functionality is toggled ON...
    if (bAutoDC)
    {
        //Override the Base DC value with an automated calculation.
        int iLevel = GetHitDice(oCreature);
        iBaseAbilityDC = 10+iLevel+iAutoDCModifier;
    }

    //Set the Base DC value for the specified Check Type
    WW_SetLocalIntForCheckTypes(iBaseAbilityDC, "iBaseAbilityDC", sCheckType, OBJECT_INVALID);

    //If DC Tracking is per creature in this Check Type...
    if (bTrackingDCPerCreature)
    {
        //Pass in the creature to determine the modifier
        iDCModifier = WW_GetDCModifier(oCreature, sCheckType);
    }
    //Otherwise...
    else
    {
        //Pass in OBJECT_INVALID to get the generic DC Modifier instead
        iDCModifier = WW_GetDCModifier(OBJECT_INVALID, sCheckType);
    }
    //Set the custom token so the creature sees the proper DC in conversation.
    int iTotalDC = iBaseAbilityDC+iDCModifier;
    string sTotalDC = IntToString(iTotalDC);

    SetCustomToken(83127, sTotalDC);
}
//END void WW_SetBaseAbilityDC()


//:://////////////////////////////////////////////
//:: WW_GetShouldDisplayAbilityCheck()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if oCreature should be able to
     see an ability check based on WW_ABILITY_*.

     NOTE: This is different from
           WW_GetHasAbility() which determines
           whether or not the ability is currently
           available to oCreature.

  VARIABLE LIST:
     sAbility = The WW_ABILITY_* being
                referenced.
     oCreature = The creature performing the check.
     bSmartLine = TRUE means the function will
                  only return TRUE if the player
                  is of Normal intelligence. FALSE
                  disables this check.
     bStupidLine = TRUE means the function will
                   only return TRUE if the player
                   is of Low intelligence. FALSE
                   disables this check.
*/
//:://////////////////////////////////////////////
int WW_GetShouldDisplayAbility(string sAbility, object oCreature,
                               int bSmartLine = FALSE, int bStupidLine = FALSE)
{
    if (sAbility == "WW_ABILITY_DEXTERITY")
    {
        //Anyone can make a Dexterity check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_STRENGTH")
    {
        //Anyone can make a Strength check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_WISDOM")
    {
        //Anyone can make a Wisdom check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_INTELLIGENCE")
    {
        //Anyone can make an Intelligence check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_CHARM_PERSON")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iDruid = GetLevelByClass(CLASS_TYPE_DRUID, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasCharm = GetHasSpell(SPELL_CHARM_PERSON, oCreature);
        int bHasCharm2 = GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0         ||
            iDruid > 0        ||
            iSorcerer > 0     ||
            iWizard > 0       ||
            bHasCharm         ||    // Bad Rob! :) bHasCharm == TRUE ||
            bHasCharm2)             //bHasCharm2 == TRUE)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_CONFUSION")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasConfuse = GetHasSpell(SPELL_CONFUSION, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0     ||
            iSorcerer > 0 ||
            iWizard > 0   ||
            bHasConfuse)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_HOLD_PERSON")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasHold = GetHasSpell(SPELL_HOLD_PERSON, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0     ||
            iCleric > 0   ||
            iSorcerer > 0 ||
            iWizard > 0   ||
            bHasHold)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_REMOVE_FEAR")
    {
        //Check the necessary parameters...
        int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCreature);
        int bHasRemove = GetHasSpell(SPELL_REMOVE_FEAR, oCreature);

        //If any of the following statements are TRUE...
        if (iCleric > 0 || bHasRemove)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_SCARE")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasScare = GetHasSpell(SPELL_SCARE, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0     ||
            iCleric > 0   ||
            iSorcerer > 0 ||
            iWizard > 0   ||
            bHasScare)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_SILENCE")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCreature);
        int bHasSilence = GetHasSpell(SPELL_SILENCE, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0     ||
            iCleric > 0   ||
            bHasSilence)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_FEEBLEMIND")
    {
        //Check the necessary parameters...
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasFeeblemind = GetHasSpell(SPELL_FEEBLEMIND, oCreature);

        //If any of the following statements are TRUE...
        if (iSorcerer > 0     ||
            iWizard > 0   ||
            bHasFeeblemind)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_MIND_FOG")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasMindFog = GetHasSpell(SPELL_MIND_FOG, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0   ||
            iSorcerer > 0     ||
            iWizard > 0   ||
            bHasMindFog)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_BEWILDERMENT")
    {
        //Check the necessary parameters...
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasBewilderment = GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT, oCreature);

        //If any of the following statements are TRUE...
        if (iSorcerer > 0     ||
            iWizard > 0   ||
            bHasBewilderment)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_DOMINATE_PERSON")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasDominate = GetHasSpell(SPELL_DOMINATE_PERSON, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0         ||
            iSorcerer > 0     ||
            iWizard > 0       ||
            bHasDominate)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_FEAR")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasFear = GetHasSpell(SPELL_FEAR, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0         ||
            iSorcerer > 0     ||
            iWizard > 0       ||
            bHasFear)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_BESTOW_CURSE")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCreature);
        int iSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER, oCreature);
        int iWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oCreature);
        int bHasCurse = GetHasSpell(SPELL_BESTOW_CURSE, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0         ||
            iCleric > 0       ||
            iSorcerer > 0     ||
            iWizard > 0       ||
            bHasCurse)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_BLESS")
    {
        //Check the necessary parameters...
        int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCreature);
        int iPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oCreature);
        int bHasBless = GetHasSpell(SPELL_BLESS, oCreature);

        //If any of the following statements are TRUE...
        if (iCleric > 0       ||
            iPaladin > 0     ||
            bHasBless)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_PRAYER")
    {
        //Check the necessary parameters...
        int iCleric = GetLevelByClass(CLASS_TYPE_CLERIC, oCreature);
        int iPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oCreature);
        int bHasPrayer = GetHasSpell(SPELL_PRAYER, oCreature);

        //If any of the following statements are TRUE...
        if (iCleric > 0       ||
            iPaladin > 0     ||
            bHasPrayer)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_WOUNDING_WHISPERS")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int bHasWhispers = GetHasSpell(SPELL_WOUNDING_WHISPERS, oCreature);

        //If any of the following statements are TRUE...
        if (iBard > 0       ||
            bHasWhispers)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_ANIMAL_EMPATHY")
    {
        int iDruid = GetLevelByClass(CLASS_TYPE_DRUID, oCreature);
        int iRanger = GetLevelByClass(CLASS_TYPE_RANGER, oCreature);
        int bHasEmpathy = GetHasSkill(SKILL_ANIMAL_EMPATHY, oCreature);

        //If oCreature has ranks in this skill...
        if (iDruid > 0       ||
            iRanger > 0     ||
            bHasEmpathy)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_LORE")
    {
        //Anyone can make an untrained Lore check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_PERFORM")
    {
        //Anyone can make an untrained Perform check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_PERSUADE")
    {
        //Anyone can make an untrained Persuade check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_SEARCH")
    {
        //Anyone can make an untrained Search check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_TAUNT")
    {
        //Anyone can make an untrained Taunt check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_USE_MAGIC_DEVICE")
    {
        int bHasUseMagicDevice = GetHasSkill(SKILL_USE_MAGIC_DEVICE, oCreature);

        //If oCreature has ranks in this skill...
        if (bHasUseMagicDevice)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_BLUFF")
    {
        //Anyone can make an untrained Bluff check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_INTIMIDATE")
    {
        //Anyone can make an untrained Intimidate check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_RAGE")
    {
        //Check the necessary parameters...
        int iBarbarian = GetLevelByClass(CLASS_TYPE_BARBARIAN, oCreature);
        int bHasRage = GetHasFeat(FEAT_BARBARIAN_RAGE, oCreature);

        //If any of the following statements are TRUE...
        if (iBarbarian >0 || bHasRage)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_STUNNING_FIST")
    {
        //Check the necessary parameters...
        int iMonk = GetLevelByClass(CLASS_TYPE_MONK, oCreature);
        int bHasStun = GetHasFeat(FEAT_STUNNING_FIST, oCreature);

        //If any of the following statements are TRUE...
        if (iMonk >0 || bHasStun)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_DIVINE_WRATH")
    {
        //Check the necessary parameters...
        int iDivineChamp = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oCreature);
        int bHasWrath = GetHasFeat(FEAT_DIVINE_WRATH, oCreature);

        //If any of the following statements are TRUE...
        if (iDivineChamp >0 || bHasWrath)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_BARD_SONG")
    {
        //Check the necessary parameters...
        int iBard = GetLevelByClass(CLASS_TYPE_BARD, oCreature);
        int bHasSong = GetHasFeat(FEAT_BARD_SONGS, oCreature);

        //If any of the following statements are TRUE...
        if (iBard >0 || bHasSong)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_LAY_HANDS")
    {
        //Check the necessary parameters...
        int iPaladin = GetLevelByClass(CLASS_TYPE_PALADIN, oCreature);
        int iDivineChamp = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oCreature);
        int bHasLayHands = GetHasFeat(FEAT_LAY_ON_HANDS, oCreature);

        //If any of the following statements are TRUE...
        if (iPaladin >0 || iDivineChamp >0 || bHasLayHands)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_DIRTY_FIGHTING")
    {
        //Check the necessary parameters...
        int bHasDirtyFighting = GetHasFeat(FEAT_DIRTY_FIGHTING, oCreature);

        //If any of the following statements are TRUE...
        if (bHasDirtyFighting)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_FLIRT")
    {
        //Check the necessary parameters...
        int iCreatureGender = GetGender(oCreature);
        int iTargetGender = GetGender(OBJECT_SELF);

        //If the creature and the target are of different genders...
        if (iCreatureGender != iTargetGender)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_KINSHIP")
    {
        //Check the necessary parameters...
        int iPCRace = GetRacialType(oCreature);
        int iNPCRace = GetRacialType(OBJECT_SELF);

        //If the creature and the target are of the same race...
        if (iPCRace == iNPCRace)
        {
            //Run it through the intelligence check
            return WW_CheckIntelligence(oCreature, bSmartLine, bStupidLine);
        }
        //Otherwise return FALSE
        return FALSE;
    }
    else
    {
        //Error Handling...
        AssignCommand(oCreature, SpeakString("ERROR: Unrecognized WW_ABILITY_* in WW_GetShouldDisplayAbilityCheck()", TALKVOLUME_SHOUT));
        return FALSE;
    }
}
//END int WW_GetShouldDisplayAbilityCheck()


//:://////////////////////////////////////////////
//:: WW_GetHasAbility()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if oCreature can currently make
     use of WW_ABILITY_*.

     NOTE: This is different from
           WW_GetShouldDisplayAbilityCheck() which
           determines whether or not oCreature
           should be able to see an ability check
           based on WW_ABILITY_*.

  VARIABLE LIST:
     sAbility = The WW_ABILITY_* being
                referenced.
     oCreature = The creature performing the check.
*/
//:://////////////////////////////////////////////
int WW_GetHasAbility(string sAbility, object oCreature)
{
    if (sAbility == "WW_ABILITY_DEXTERITY")
    {
        //Anyone can make a Dexterity check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_STRENGTH")
    {
        //Anyone can make a Strength check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_WISDOM")
    {
        //Anyone can make a Wisdom check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_INTELLIGENCE")
    {
        //Anyone can make an Intelligence check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_CHARM_PERSON")
    {
        //Check for charm spells.
        int bHasCharm = GetHasSpell(SPELL_CHARM_PERSON, oCreature);
        int bHasCharmAnimal = GetHasSpell(SPELL_CHARM_PERSON_OR_ANIMAL, oCreature);

        //If either spell is available...
        if (bHasCharm ||
            bHasCharmAnimal)
        {
            return TRUE;
        }
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_CONFUSION")
    {
        return GetHasSpell(SPELL_CONFUSION, oCreature);
    }
    else if (sAbility == "WW_ABILITY_HOLD_PERSON")
    {
        return GetHasSpell(SPELL_HOLD_PERSON, oCreature);
    }
    else if (sAbility == "WW_ABILITY_REMOVE_FEAR")
    {
        return GetHasSpell(SPELL_REMOVE_FEAR, oCreature);
    }
    else if (sAbility == "WW_ABILITY_SCARE")
    {
        return GetHasSpell(SPELL_SCARE, oCreature);
    }
    else if (sAbility == "WW_ABILITY_SILENCE")
    {
        return GetHasSpell(SPELL_SILENCE, oCreature);
    }
    else if (sAbility == "WW_ABILITY_FEEBLEMIND")
    {
        return GetHasSpell(SPELL_FEEBLEMIND, oCreature);
    }
    else if (sAbility == "WW_ABILITY_MIND_FOG")
    {
        return GetHasSpell(SPELL_MIND_FOG, oCreature);
    }
    else if (sAbility == "WW_ABILITY_BEWILDERMENT")
    {
        return GetHasSpell(SPELL_CLOUD_OF_BEWILDERMENT, oCreature);
    }
    else if (sAbility == "WW_ABILITY_DOMINATE_PERSON")
    {
        return GetHasSpell(SPELL_DOMINATE_PERSON, oCreature);
    }
    else if (sAbility == "WW_ABILITY_FEAR")
    {
        return GetHasSpell(SPELL_FEAR, oCreature);
    }
    else if (sAbility == "WW_ABILITY_BESTOW_CURSE")
    {
        return GetHasSpell(SPELL_BESTOW_CURSE, oCreature);
    }
    else if (sAbility == "WW_ABILITY_BLESS")
    {
        return GetHasSpell(SPELL_BLESS, oCreature);
    }
    else if (sAbility == "WW_ABILITY_PRAYER")
    {
        return GetHasSpell(SPELL_PRAYER, oCreature);
    }
    else if (sAbility == "WW_ABILITY_WOUNDING_WHISPERS")
    {
        return GetHasSpell(SPELL_WOUNDING_WHISPERS, oCreature);
    }
    else if (sAbility == "WW_ABILITY_ANIMAL_EMPATHY")
    {
        return GetHasSkill(SKILL_ANIMAL_EMPATHY, oCreature);
    }
    else if (sAbility == "WW_ABILITY_LORE")
    {
        //Anyone can make an untrained Lore check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_PERFORM")
    {
        //Anyone can make an untrained Perform check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_PERSUADE")
    {
        //Anyone can make an untrained Persuade check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_SEARCH")
    {
        //Anyone can make an untrained Search check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_TAUNT")
    {
        //Anyone can make an untrained Taunt check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_USE_MAGIC_DEVICE")
    {
        return GetHasSkill(SKILL_USE_MAGIC_DEVICE, oCreature);
    }
    else if (sAbility == "WW_ABILITY_BLUFF")
    {
        //Anyone can make an untrained Bluff check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_INTIMIDATE")
    {
        //Anyone can make an untrained Intimidate check.
        return TRUE;
    }
    else if (sAbility == "WW_ABILITY_RAGE")
    {
        //Check for rage abilities.
        int bHasRageFeat = GetHasFeat(FEAT_BARBARIAN_RAGE, oCreature);
        int bHasRageAbility1 = GetHasSpell(SPELLABILITY_BARBARIAN_RAGE, oCreature);
        int bHasRageAbility2 = GetHasSpell(SPELLABILITY_RAGE_3, oCreature);
        int bHasRageAbility3 = GetHasSpell(SPELLABILITY_RAGE_4, oCreature);
        int bHasRageAbility4 = GetHasSpell(SPELLABILITY_RAGE_5, oCreature);

        //If any rage ability is available...
        if (bHasRageFeat ||
            bHasRageAbility1 ||
            bHasRageAbility2 ||
            bHasRageAbility3 ||
            bHasRageAbility4)
        {
            return TRUE;
        }
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_STUNNING_FIST")
    {
        return GetHasFeat(FEAT_STUNNING_FIST, oCreature);
    }
    else if (sAbility == "WW_ABILITY_DIVINE_WRATH")
    {
        return GetHasFeat(FEAT_DIVINE_WRATH, oCreature);
    }
    else if (sAbility == "WW_ABILITY_BARD_SONG")
    {
        return GetHasFeat(FEAT_BARD_SONGS, oCreature);
    }
    else if (sAbility == "WW_ABILITY_LAY_HANDS")
    {
        return GetHasFeat(FEAT_LAY_ON_HANDS, oCreature);
    }
    else if (sAbility == "WW_ABILITY_DIRTY_FIGHTING")
    {
        return GetHasFeat(FEAT_DIRTY_FIGHTING, oCreature);
    }
    else if (sAbility == "WW_ABILITY_FLIRT")
    {
        //Check the necessary parameters...
        int iCreatureGender = GetGender(oCreature);
        int iTargetGender = GetGender(OBJECT_SELF);

        //If the creatures are of different genders...
        if (iCreatureGender != iTargetGender)
        {
            return TRUE;
        }
        return FALSE;
    }
    else if (sAbility == "WW_ABILITY_KINSHIP")
    {
        //Check the necessary parameters...
        int iPCRace = GetRacialType(oCreature);
        int iNPCRace = GetRacialType(OBJECT_SELF);

        //If the creature and target are of the same race...
        if (iPCRace == iNPCRace)
        {
            return TRUE;
        }
        return FALSE;
    }
    else
    {
        //Error Handling...
        AssignCommand(oCreature, SpeakString("ERROR: Unrecognized WW_ABILITY_* in WW_GetHasAbility()", TALKVOLUME_SHOUT));
        return FALSE;
    }
}
//END int WW_GetHasAbility()


//:://////////////////////////////////////////////
//:: WW_DoAbilityCheck()
//:: RETURN TYPE: Integer
//:://////////////////////////////////////////////
/*
     Returns -3 if asked to use an unknown ability
     Returns -2 if oCreature doesn't currently
        have that ability
     Returns -1 if oCreature is making an illegal
        Retry.
     Returns O if oCreature Fails their check.
     Returns 1 if oCreature Succeeds their check.

     These values will also be saved out as local
     ints on OBJECT_SELF (errors are saved
     separately from success or failure).

  VARIABLE LIST:
     sAbility = The WW_ABILITY_* being
                referenced.
     oCreature = The creature performing the check.
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_DoAbilityCheck(string sAbility, object oCreature,
                      string sCheckType = "WW_CHECK_TYPE_ALL")
{
    //Determine the Creature's ID
    string sCreatureID = WW_GetCreatureID(oCreature);

    //Determine the Initialized values
    int bTrackResultPerCreature = WW_GetIsResultTrackedPerCreature(sCheckType);
    int bAllowRetry = WW_GetIsRetryAllowed(sCheckType);
    int iDCIncreaseOnFailure = WW_GetDCIncreaseOnFailure(sCheckType);
    int bTrackDCPerCreature = WW_GetIsDCTrackedPerCreature(sCheckType);

    //If Retries are not allowed...
    if (bAllowRetry == FALSE)
    {
        int iPastResult;

        //Check for creature-specific past results if neeeded
        if (bTrackResultPerCreature)
        {
            //Verify that it's not a Retry for that creature
            iPastResult = GetLocalInt(OBJECT_SELF, "iAbilityResult"+sCheckType+sCreatureID);
        }
        //Otherwise check the generic results...
        else
        {
            //Verify that it's not a generic Retry
            iPastResult = GetLocalInt(OBJECT_SELF, "iAbilityResult"+sCheckType);
        }

        //If it is a Retry...
        if (iPastResult != TRUE)
        {
            //Track Illegal Retry per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-1, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-1, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            //Return -1 to indicate an illegal Retry
            return -1;
        }
    }

    //Get the Base DC.
    string sBaseDC = "iBaseAbilityDC"+sCheckType;
    int iBaseDC = GetLocalInt(OBJECT_SELF, sBaseDC);

    //Assume there's no DC modifier...
    int iDCModifier = 0;

    //But apply a DC modifier if it's needed.
    if (iDCIncreaseOnFailure)
    {
        //Track the DC modifier per creature if needed
        if (bTrackDCPerCreature)
        {
            //Use the Creature's ID to find the per creature DC Modifier
            iDCModifier = WW_GetDCModifier(oCreature, sCheckType);
        }
        //Otherwise just get the generic DC modifier
        else
        {
            iDCModifier = WW_GetDCModifier(OBJECT_INVALID, sCheckType);
        }
    }

    //Declare values used in the following calculations
    int iDC = iBaseDC+iDCModifier;
    int iD20 = Random(20)+1;
    int iCharLevel = GetHitDice(oCreature);
    int iChaMod = GetAbilityModifier(ABILITY_CHARISMA, oCreature);
    int iDexMod = GetAbilityModifier(ABILITY_DEXTERITY, oCreature);
    int iIntMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oCreature);
    int iStrMod = GetAbilityModifier(ABILITY_STRENGTH, oCreature);
    int iWisMod = GetAbilityModifier(ABILITY_WISDOM, oCreature);
    int iLore = GetSkillRank(SKILL_LORE, oCreature);
    int iPerform = GetSkillRank(SKILL_PERFORM, oCreature);
    int iPersuade = GetSkillRank(SKILL_PERSUADE, oCreature);
    int iSearch = GetSkillRank(SKILL_SEARCH, oCreature);
    int iTaunt = GetSkillRank(SKILL_TAUNT, oCreature);
    int iEmpathy = GetSkillRank(SKILL_ANIMAL_EMPATHY, oCreature);
    int iUseMagicDevice = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oCreature);
    int iBluff = GetSkillRank(SKILL_BLUFF, oCreature);
    int iIntimidate = GetSkillRank(SKILL_INTIMIDATE, oCreature);
    int iMonkLevels = GetLevelByClass(CLASS_TYPE_MONK, oCreature);
    int iClassPenalty = 0;
    int iCheck;

    //Declare values specific to spell use
    int iAbilityType;
    int iAbilMod;
    int iSpell;
    int iClass1Level = GetLevelByPosition(1, oCreature);
    int iClass2Level = GetLevelByPosition(2, oCreature);
    int iClass3Level = GetLevelByPosition(3, oCreature);
    int iClass1 = GetClassByPosition(1, oCreature);
    int iClass2 = GetClassByPosition(2, oCreature);
    int iClass3 = GetClassByPosition(3, oCreature);

    //Handle the various ability checks
    if (sAbility == "WW_ABILITY_DEXTERITY")
    {
        iCheck = iD20 + iDexMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_STRENGTH")
    {
        iCheck = iD20 + iStrMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_WISDOM")
    {
        iCheck = iD20 + iWisMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_INTELLIGENCE")
    {
        iCheck = iD20 + iIntMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_CHARM_PERSON")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to whether they used "Charm Person" or "Charm
        //Person or Animal"
        if (GetHasSpell(SPELL_CHARM_PERSON, oCreature))
            iSpell = SPELL_CHARM_PERSON;
        else
            iSpell = SPELL_CHARM_PERSON_OR_ANIMAL;

        //If they used "Charm Person or Animal", use their Wisdom modifier
        if (iSpell == SPELL_CHARM_PERSON_OR_ANIMAL)
            iAbilityType = ABILITY_WISDOM;
        //Otherwise start doing some educated guessing as to what class they might
        //be casting from so you can use the appropriate ability score modifier.
        //Class 1:
        else if (iClass1 == CLASS_TYPE_WIZARD)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass1 == CLASS_TYPE_SORCERER ||
                 (iClass1 == CLASS_TYPE_BARD &&
                  iClass1Level >= 2))
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass2 == CLASS_TYPE_SORCERER ||
                 (iClass2 == CLASS_TYPE_BARD &&
                  iClass1Level >= 2))
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass3 == CLASS_TYPE_SORCERER ||
                 (iClass3 == CLASS_TYPE_BARD &&
                  iClass1Level >= 2))
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, iSpell, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_CONFUSION")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
            iClass1Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass1 == CLASS_TYPE_SORCERER &&
                  iClass1Level >= 8) ||
                 (iClass1 == CLASS_TYPE_BARD &&
                  iClass1Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
                 iClass2Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass2 == CLASS_TYPE_SORCERER &&
                  iClass2Level >= 8) ||
                 (iClass2 == CLASS_TYPE_BARD &&
                  iClass2Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
                 iClass3Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass3 == CLASS_TYPE_SORCERER &&
                  iClass3Level >= 8) ||
                 (iClass3 == CLASS_TYPE_BARD &&
                  iClass3Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_CONFUSION, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_HOLD_PERSON")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
            iClass1Level >= 5)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass1 == CLASS_TYPE_SORCERER &&
                  iClass1Level >= 6) ||
                 (iClass1 == CLASS_TYPE_BARD &&
                  iClass1Level >= 4))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass1 == CLASS_TYPE_CLERIC &&
                 iClass1Level >= 3)
            iAbilityType = ABILITY_WISDOM;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
            iClass2Level >= 5)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass2 == CLASS_TYPE_SORCERER &&
                  iClass2Level >= 6) ||
                 (iClass2 == CLASS_TYPE_BARD &&
                  iClass2Level >= 4))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass2 == CLASS_TYPE_CLERIC &&
                 iClass2Level >= 3)
            iAbilityType = ABILITY_WISDOM;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
            iClass3Level >= 5)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass3 == CLASS_TYPE_SORCERER &&
                  iClass3Level >= 6) ||
                 (iClass3 == CLASS_TYPE_BARD &&
                  iClass3Level >= 4))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass3 == CLASS_TYPE_CLERIC &&
                 iClass3Level >= 3)
            iAbilityType = ABILITY_WISDOM;
        //For Special Abilities, use Wisdom:
        else
            iAbilityType = ABILITY_WISDOM;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_HOLD_PERSON, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_REMOVE_FEAR")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //The only possible ability type for this spell is Wisdom.
        iAbilityType = ABILITY_WISDOM;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_REMOVE_FEAR, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_SCARE")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass1 == CLASS_TYPE_SORCERER ||
                 (iClass1 == CLASS_TYPE_BARD &&
                  iClass1Level >= 2))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass1 == CLASS_TYPE_CLERIC)
            iAbilityType = ABILITY_WISDOM;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass2 == CLASS_TYPE_SORCERER ||
                 (iClass2 == CLASS_TYPE_BARD &&
                  iClass2Level >= 2))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass2 == CLASS_TYPE_CLERIC)
            iAbilityType = ABILITY_WISDOM;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass3 == CLASS_TYPE_SORCERER ||
                 (iClass3 == CLASS_TYPE_BARD &&
                  iClass3Level >= 2))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass3 == CLASS_TYPE_CLERIC)
            iAbilityType = ABILITY_WISDOM;
        //For Special Abilities, use Intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_SCARE, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_SILENCE")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_CLERIC &&
            iClass1Level >= 3)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass1 == CLASS_TYPE_BARD &&
                 iClass1Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass1 == CLASS_TYPE_CLERIC &&
            iClass1Level >= 3)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass1 == CLASS_TYPE_BARD &&
                 iClass1Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass1 == CLASS_TYPE_CLERIC &&
            iClass1Level >= 3)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass1 == CLASS_TYPE_BARD &&
                 iClass1Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use Wisdom:
        else
            iAbilityType = ABILITY_WISDOM;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_SILENCE, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_FEEBLEMIND")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
            iClass1Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass1 == CLASS_TYPE_SORCERER &&
                 iClass1Level >= 10)
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
                 iClass2Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass2 == CLASS_TYPE_SORCERER &&
                 iClass2Level >= 10)
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
                 iClass3Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass3 == CLASS_TYPE_SORCERER &&
                 iClass3Level >= 10)
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use Intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_FEEBLEMIND, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_MIND_FOG")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
            iClass1Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass1 == CLASS_TYPE_SORCERER &&
                  iClass1Level >= 10) ||
                 (iClass1 == CLASS_TYPE_BARD &&
                  iClass1Level >= 13))
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
                 iClass2Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass2 == CLASS_TYPE_SORCERER &&
                  iClass2Level >= 10) ||
                 (iClass2 == CLASS_TYPE_BARD &&
                  iClass2Level >= 13))
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
                 iClass3Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass3 == CLASS_TYPE_SORCERER &&
                  iClass3Level >= 10) ||
                 (iClass3 == CLASS_TYPE_BARD &&
                  iClass3Level >= 13))
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use Intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_MIND_FOG, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_BEWILDERMENT")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
            iClass1Level >= 3)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass1 == CLASS_TYPE_SORCERER &&
                 iClass1Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
                 iClass2Level >= 3)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass2 == CLASS_TYPE_SORCERER &&
                 iClass2Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
                 iClass3Level >= 3)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if (iClass3 == CLASS_TYPE_SORCERER &&
                 iClass3Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use Intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_CLOUD_OF_BEWILDERMENT, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_DOMINATE_PERSON")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
                 iClass1Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass1 == CLASS_TYPE_SORCERER ||
                  iClass1 == CLASS_TYPE_BARD) &&
                  iClass1Level >= 10)
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
                 iClass2Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass2 == CLASS_TYPE_SORCERER ||
                  iClass2 == CLASS_TYPE_BARD) &&
                  iClass2Level >= 10)
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
                 iClass3Level >= 9)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass3 == CLASS_TYPE_SORCERER ||
                  iClass3 == CLASS_TYPE_BARD) &&
                  iClass3Level >= 10)
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_DOMINATE_PERSON, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_FEAR")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
                 iClass1Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass1 == CLASS_TYPE_SORCERER &&
                  iClass1Level >= 8) ||
                 (iClass1 == CLASS_TYPE_BARD &&
                  iClass1Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
                 iClass2Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass2 == CLASS_TYPE_SORCERER &&
                  iClass2Level >= 8) ||
                 (iClass2 == CLASS_TYPE_BARD &&
                  iClass2Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
                 iClass3Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass3 == CLASS_TYPE_SORCERER &&
                  iClass3Level >= 8) ||
                 (iClass3 == CLASS_TYPE_BARD &&
                  iClass3Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use intelligence:
        else
            iAbilityType = ABILITY_INTELLIGENCE;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_FEAR, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_BESTOW_CURSE")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_WIZARD &&
                 iClass1Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass1 == CLASS_TYPE_SORCERER &&
                  iClass1Level >= 8) ||
                 (iClass1 == CLASS_TYPE_BARD &&
                  iClass1Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass1 == CLASS_TYPE_CLERIC &&
                 iClass1Level >= 5)
            iAbilityType = ABILITY_WISDOM;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_WIZARD &&
                 iClass2Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass2 == CLASS_TYPE_SORCERER &&
                  iClass2Level >= 8) ||
                 (iClass2 == CLASS_TYPE_BARD &&
                  iClass2Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass2 == CLASS_TYPE_CLERIC &&
                 iClass2Level >= 5)
            iAbilityType = ABILITY_WISDOM;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_WIZARD &&
                 iClass3Level >= 7)
            iAbilityType = ABILITY_INTELLIGENCE;
        else if ((iClass3 == CLASS_TYPE_SORCERER &&
                  iClass3Level >= 8) ||
                 (iClass3 == CLASS_TYPE_BARD &&
                  iClass3Level >= 7))
            iAbilityType = ABILITY_CHARISMA;
        else if (iClass3 == CLASS_TYPE_CLERIC &&
                 iClass3Level >= 5)
            iAbilityType = ABILITY_WISDOM;
        //For Special Abilities, use wisdom:
        else
            iAbilityType = ABILITY_WISDOM;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_BESTOW_CURSE, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_BLESS")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_CLERIC)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass1 == CLASS_TYPE_PALADIN &&
                 iClass1Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_CLERIC)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass2 == CLASS_TYPE_PALADIN &&
                 iClass2Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_CLERIC)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass3 == CLASS_TYPE_PALADIN &&
                 iClass3Level >= 4)
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use wisdom:
        else
            iAbilityType = ABILITY_WISDOM;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_BLESS, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_PRAYER")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Make an educated guess as to what class they might be casting from so you
        //can use the appropriate ability score modifier.
        //Class 1:
        if (iClass1 == CLASS_TYPE_CLERIC &&
            iClass1Level >= 5)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass1 == CLASS_TYPE_PALADIN &&
                 iClass1Level >= 14)
            iAbilityType = ABILITY_CHARISMA;
        //Class 2:
        else if (iClass2 == CLASS_TYPE_CLERIC &&
                 iClass2Level >= 5)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass2 == CLASS_TYPE_PALADIN &&
                 iClass2Level >= 14)
            iAbilityType = ABILITY_CHARISMA;
        //Class 3:
        else if (iClass3 == CLASS_TYPE_CLERIC &&
                 iClass2Level >= 5)
            iAbilityType = ABILITY_WISDOM;
        else if (iClass3 == CLASS_TYPE_PALADIN &&
                 iClass3Level >= 14)
            iAbilityType = ABILITY_CHARISMA;
        //For Special Abilities, use wisdom:
        else
            iAbilityType = ABILITY_WISDOM;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_PRAYER, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_WOUNDING_WHISPERS")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Assume they're casting it as a Bard so you can use the appropriate
        //ability score modifier.
        iAbilityType = ABILITY_CHARISMA;

        //Cast the fake spell and determine the Ability Modifier.
        iAbilMod = WW_CastSpellInConversation(oCreature, SPELL_WOUNDING_WHISPERS, iAbilityType);
        //Create the final Check calculation.
        iCheck = iD20 + iAbilMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_ANIMAL_EMPATHY")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Create the final Check calculation.
        iCheck = iD20 + iEmpathy;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_LORE")
    {
        iCheck = iD20 + iLore;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_PERFORM")
    {
        iCheck = iD20 + iPerform;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_PERSUADE")
    {
        iCheck = iD20 + iPersuade;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_SEARCH")
    {
        iCheck = iD20 + iSearch;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_TAUNT")
    {
        iCheck = iD20 + iTaunt;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_USE_MAGIC_DEVICE")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Create the final Check calculation.
        iCheck = iD20 + iUseMagicDevice;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_BLUFF")
    {
        iCheck = iD20 + iBluff;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_INTIMIDATE")
    {
        iCheck = iD20 + iIntimidate;//Modifier already taken into account in GetSkillRank()
    }
    else if (sAbility == "WW_ABILITY_RAGE")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Use their fake Rage feat
        WW_UseRageInConversation(oCreature);
        //Create the final Check calculation.
        iCheck = iD20 + iStrMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_STUNNING_FIST")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Decrement the PC's Stunning Fist feat.
        DecrementRemainingFeatUses(oCreature, FEAT_STUNNING_FIST);
        //Apply a penalty if they're not a Monk.
        if(iMonkLevels == 0)
        {
            iClassPenalty = -4;
        }
        //Create the final Check calculation.
        iCheck = iD20 + iWisMod + iCharLevel + iClassPenalty;
    }
    else if (sAbility == "WW_ABILITY_DIVINE_WRATH")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Decrement the PC's Divine Wrath feat.
        DecrementRemainingFeatUses(oCreature, FEAT_DIVINE_WRATH);
        //Create the final Check calculation.
        iCheck = iD20 + iWisMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_BARD_SONG")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Decrement the PC's Bard Songs feat.
        DecrementRemainingFeatUses(oCreature, FEAT_BARD_SONGS);
        //Create the final Check calculation.
        iCheck = iD20 + iChaMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_LAY_HANDS")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Decrement the PC's Lay On Hands feat.
        DecrementRemainingFeatUses(oCreature, FEAT_LAY_ON_HANDS);
        //Create the final Check calculation.
        iCheck = iD20 + iChaMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_DIRTY_FIGHTING")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Decrement the PC's Dirty Fighting feat.
        DecrementRemainingFeatUses(oCreature, FEAT_DIRTY_FIGHTING);
        //Create the final Check calculation.
        iCheck = iD20 + iDexMod + iCharLevel;
    }
    else if (sAbility == "WW_ABILITY_FLIRT")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Create the final Check calculation.
        iCheck = iD20 + (iChaMod * 4);
    }
    else if (sAbility == "WW_ABILITY_KINSHIP")
    {
        //Return -2 if the creature doesn't have this ability.
        if (WW_GetHasAbility(sAbility, oCreature) == FALSE)
        {
            //Track Lack of Ability per creature if needed
            if (bTrackResultPerCreature)
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(-2, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
            }
            return -2;
        }
        //Assign a Persuade bonus due to Kinship.
        int iKinBonus = 5;
        //Create the final Check calculation.
        iCheck = iD20 + iPersuade + iKinBonus;//Modifier already taken into account in GetSkillRank()
    }
    else
    {
        //Error Handling...
        AssignCommand(oCreature, SpeakString("ERROR: Unrecognized WW_ABILITY_* in WW_DoAbilityCheck()", TALKVOLUME_SHOUT));

        //Track it per creature if necessary.
        if (bTrackResultPerCreature)
        {
            WW_SetLocalIntForCheckTypes(-3, "iAbilityResultAborted", sCheckType, oCreature);
        }
        //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
        else
        {
            WW_SetLocalIntForCheckTypes(-3, "iAbilityResultAborted", sCheckType, OBJECT_INVALID);
        }

        //Return -3 to indicate Unrecognized Ability Error
        return -3;
    }

    //Convert the above Ints to Strings in preparation for broadcast.
    string sDC = IntToString(iDC);
    string sCheck = IntToString(iCheck);
    string sBroadcast = "You roll: "+sCheck+" vs. DC "+sDC;

    //If the Creature's Check >= DC, they succeed.
    if (iCheck >= iDC)
    {
        //Track Success per creature if needed
        if (bTrackResultPerCreature)
        {
            WW_SetLocalIntForCheckTypes(1, "iAbilityResult", sCheckType, oCreature);
        }
        //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
        else
        {
            WW_SetLocalIntForCheckTypes(1, "iAbilityResult", sCheckType, OBJECT_INVALID);
        }

        //Send dice roll message to creature
        SendMessageToPC(oCreature, "[Success] " + sBroadcast);

        //Return 1 to indicate Success
        return 1;
    }
    //If not, they fail.
    else
    {
        //Track Failure per creature if needed
        if (bTrackResultPerCreature)
        {
            WW_SetLocalIntForCheckTypes(0, "iAbilityResult", sCheckType, oCreature);
        }
        //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
        else
        {
            WW_SetLocalIntForCheckTypes(0, "iAbilityResult", sCheckType, OBJECT_INVALID);
        }

        //Send dice roll message to creature
        SendMessageToPC(oCreature, "[Failure] " + sBroadcast);

        //Increase the Retry DC if necessary
        if (iDCIncreaseOnFailure)
        {
            //Track DC Increase per creature if needed
            if (bTrackDCPerCreature)
            {
                WW_SetLocalIntForCheckTypes(iDCModifier+iDCIncreaseOnFailure, "sDCModifier", sCheckType, oCreature);
            }
            //Otherwise feed in an OBJECT_INVALID so it handles only the generic case.
            else
            {
                WW_SetLocalIntForCheckTypes(iDCModifier+iDCIncreaseOnFailure, "sDCModifier", sCheckType, OBJECT_INVALID);
            }
        }

        //Return 0 to indicate Failure
        return 0;
    }
}
//END int WW_DoAbilityCheck()


//:://////////////////////////////////////////////
//:: WW_GetAbilityCheckSuccess()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if the ability check is
     considered successful for oCreature.

  VARIABLE LIST:
     oCreature = The creature on whose behalf the
                 reference is being made.
                 OBJECT_INVALID will return TRUE
                 if anyone has been successful.
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetAbilityCheckSuccess(object oCreature = OBJECT_INVALID,
                              string sCheckType = "WW_CHECK_TYPE_ALL")
{
    int iResult;

    //If a valid creature has been passed in...
    //if (oCreature != OBJECT_INVALID)
    if(GetIsObjectValid(oCreature))
    {
        //Determine the Creature's ID
        string sCreatureID = WW_GetCreatureID(oCreature);

        //Check that creature's results
        iResult = GetLocalInt(OBJECT_SELF, "iAbilityResult"+sCheckType+sCreatureID);
    }
    //Otherwise check the generic result.
    else
    {
        iResult = GetLocalInt(OBJECT_SELF, "iAbilityResult"+sCheckType);
    }

    //Return TRUE if the result is Failure...
    //Otherwise return FALSE

    return iResult;
}
//END int WW_GetAbilityCheckSuccess()


//:://////////////////////////////////////////////
//:: WW_GetAbilityCheckFailed()
//:: RETURN TYPE: Boolean
//:://////////////////////////////////////////////
/*
     Returns TRUE if the ability check is
     considered a failure for oCreature.

  VARIABLE LIST:
     oCreature = The creature on whose behalf the
                 reference is being made.
                 OBJECT_INVALID will return TRUE
                 if anyone has failed.
     sCheckType = The WW_CHECK_TYPE_* being
                  referenced.
*/
//:://////////////////////////////////////////////
int WW_GetAbilityCheckFailed(object oCreature = OBJECT_INVALID,
                             string sCheckType = "WW_CHECK_TYPE_ALL")
{
    int iResult;

    //If a valid creature has been passed in...
    //if (oCreature != OBJECT_INVALID)
    if(GetIsObjectValid(oCreature))
    {
        //Determine the Creature's ID
        string sCreatureID = WW_GetCreatureID(oCreature);

        //Check that creature's results
        iResult = GetLocalInt(OBJECT_SELF, "iAbilityResult"+sCheckType+sCreatureID);
    }
    //Otherwise check the generic result.
    else
    {
        iResult = GetLocalInt(OBJECT_SELF, "iAbilityResult"+sCheckType);
    }

    //Return TRUE if the result is Failure...
    if (iResult == FALSE)
    {
        iResult = TRUE;
    }
    else //Otherwise return FALSE
    {
        iResult = FALSE;
    }
    return iResult;
}
//END int WW_GetAbilityCheckFailed()


//:://////////////////////////////////////////////
//:: WW_DoAbilityConsequences()
//:: RETURN TYPE: Void
//:://////////////////////////////////////////////
/*
     Performs some typical actions that can
     result within the Ability Check system.

  VARIABLE LIST:
     sConsequence = The WW_CONSEQUENCE_* to be
                    performed.
     oCreature = The creature who performed the
                 check.
*/
//:://////////////////////////////////////////////
void WW_DoAbilityConsequences(string sConsequence, object oCreature)
{
    if (sConsequence == "WW_CONSEQUENCE_ALARM")
    {
        //NOTE: oCreature is irrelevant to this consequence. Feel free to pass
        //      in OBJECT_INVALID if you don't have an appropriate object
        //      available.
        object oArea = GetArea(OBJECT_SELF);

        //Have the creature say appropriate VO if they have it.
        PlayVoiceChat(VOICE_CHAT_ENEMIES);
        DelayCommand(2.0, PlayVoiceChat(VOICE_CHAT_ATTACK));

        //Signal the UserDefinedEvent on the current area.
        //Custom alarm reactions can be scripted there.
        //EventNumber = 1701
        SignalEvent(oArea, EventUserDefined(1701));
    }
    else if (sConsequence == "WW_CONSEQUENCE_CLIMB")
    {
        //Get the tag of the object oCreature is talking to and use it to
        //define the appropriate Climb Target (which must be unique)
        string sTag = GetTag(OBJECT_SELF);
        string sClimbTarget = "CLIMB_"+sTag;
        object oClimbTarget = GetObjectByTag(sClimbTarget);

        //Identify any associates of oCreature that will also need to make the
        //jump.
        object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oCreature);
        object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oCreature);
        object oAnimalCompanion = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oCreature);
        object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCreature);

        //Jump oCreature and any associates to the Climb Target
        AssignCommand(oCreature, JumpToObject(oClimbTarget));
        AssignCommand(oHenchman, JumpToObject(oClimbTarget));
        AssignCommand(oFamiliar, JumpToObject(oClimbTarget));
        AssignCommand(oAnimalCompanion, JumpToObject(oClimbTarget));
        AssignCommand(oSummoned, JumpToObject(oClimbTarget));

        //Update that creature's Climb Status (remember to set it to FALSE when
        //they climb down again).
        string sCreatureID = WW_GetCreatureID(oCreature);
        SetLocalInt(oClimbTarget, "CLIMB_STATUS_"+sCreatureID, TRUE);
    }
    else if (sConsequence == "WW_CONSEQUENCE_KILL")
    {
        effect eDeath = EffectDeath(TRUE);
        AssignCommand(oCreature, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0, 0.4));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDeath, OBJECT_SELF, 0.5);
    }
    else if (sConsequence == "WW_CONSEQUENCE_PARALYZE")
    {
        effect eHold = EffectParalyze();
        effect eVFX = EffectVisualEffect(VFX_IMP_DAZED_S);

        //Silence the Target.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHold, OBJECT_SELF, 60.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, OBJECT_SELF, 60.0);

        //Turn the Target hostile.
        SetIsTemporaryEnemy(oCreature);

        //Run DetermineCombatRound() as a separate script b/c nw_i0_generic is
        //too large to include in this file.
        ExecuteScript("ww_combatround", OBJECT_SELF);

        //Sound the alarm if I'm still alive once the Paralyze effect has worn off
        //(UserDefinedEvent #1701 on the current Area).
        DelayCommand(60.0, WW_DoAbilityConsequences("WW_CONSEQUENCE_ALARM", oCreature));
    }
    else if (sConsequence == "WW_CONSEQUENCE_SILENCE")
    {
        effect eSilence = EffectSilence();

        //Silence the Target.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilence, OBJECT_SELF, 120.0);

        //Turn the Target hostile.
        SetIsTemporaryEnemy(oCreature);

        //Run DetermineCombatRound() as a separate script b/c nw_i0_generic is
        //too large to include in this file.
        ExecuteScript("ww_combatround", OBJECT_SELF);

        //Sound the alarm if I'm still alive once the Silence effect has worn off
        //(UserDefinedEvent #1701 on the current Area).
        DelayCommand(120.0, WW_DoAbilityConsequences("WW_CONSEQUENCE_ALARM", oCreature));
    }
    else
    {
        //Error Handling...
        AssignCommand(oCreature, SpeakString("ERROR: Unrecognized WW_CONSEQUENCE_* in WW_DoAbilityConsequences()", TALKVOLUME_SHOUT));
    }
}
//END void WW_DoAbilityConsquences()
