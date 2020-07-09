/*void main()
{

} */

void SetCasterClass(object oNPC)
{
    int nClass = GetLastSpellCastClass();

    SetLocalInt(oNPC, "HF_SPELL_CASTER_CLASS", nClass);
}

int GetCasterClass(object oNPC)
{
    return(GetLocalInt(oNPC, "HF_SPELL_CASTER_CLASS"));
}

// Determine which ability bonus to apply to save based on class casting spell
void SetCasterAbilityModifier(object oPC, object oNPC)
{
    int nAbilityModifier;
    int nCasterAbility;
    int nClass = GetCasterClass(oNPC);

    switch(nClass)
    {
        case CLASS_TYPE_BARD :
        case CLASS_TYPE_SORCERER :
             nCasterAbility = ABILITY_CHARISMA;
        break;

        case CLASS_TYPE_WIZARD :
             nCasterAbility = ABILITY_INTELLIGENCE;
        break;

        case CLASS_TYPE_CLERIC :
        case CLASS_TYPE_DRUID :
        case CLASS_TYPE_PALADIN :
        case CLASS_TYPE_RANGER :
             nCasterAbility = ABILITY_WISDOM;
        break;

        default :
             nCasterAbility = ABILITY_INTELLIGENCE;
        break;
    }

    //Get the ability bonus for the relevant caster ability
    nAbilityModifier = GetAbilityModifier(nCasterAbility, oPC);

    SetLocalInt(oNPC, "HF_SPELL_ABILITY_MOD", nAbilityModifier);
}

// set the spell level, saving throw type, and VFX of the spell
void SpellSetSpellDetails(object oNPC, int nSpell)
{
    //Caster class set in SetCasterAbilityModifier
    int nCasterClass = GetLocalInt(oNPC, "HF_SPELL_CASTER_CLASS");
    int nSpellLevel = 0;
    int nSpellSaveFailVFX = 0;
    int nSpellSaveType = 0;

    switch(nSpell)
    {
        case SPELL_CHARM_PERSON :
             nSpellLevel = 1;
             nSpellSaveType = SAVING_THROW_WILL;
             nSpellSaveFailVFX = VFX_IMP_CHARM;
        break;

        case SPELL_CHARM_PERSON_OR_ANIMAL :
             nSpellLevel = 1;
             nSpellSaveType = SAVING_THROW_WILL;
             nSpellSaveFailVFX = VFX_IMP_CHARM;
        break;

        //Fear is 3rd level for Bard, 4th for Sorcerer/Wizard
        case SPELL_FEAR :
             nSpellLevel = 1;
             if(nCasterClass == CLASS_TYPE_BARD)
             {
                nSpellLevel = 3;
             }
             else
             {
                nSpellLevel = 4;
             }
             nSpellSaveType = SAVING_THROW_WILL;
             nSpellSaveFailVFX = VFX_IMP_FEAR_S;
        break;

        //Dominate Person is 4th level for Bard, 5th for Sorcerer/Wizard
        case SPELL_DOMINATE_PERSON :
             if(nCasterClass == CLASS_TYPE_BARD)
             {
                nSpellLevel = 4;
             }
             else
             {
                nSpellLevel = 5;
             }
             nSpellSaveType = SAVING_THROW_WILL;
             nSpellSaveFailVFX = VFX_IMP_DOMINATE_S;
        break;

        //No saving throw
        case SPELL_WOUNDING_WHISPERS :
             nSpellLevel = 3;
             nSpellSaveFailVFX = VFX_IMP_SONIC;
        break;

        default :
            nSpellLevel = 1;
            nSpellSaveType = SAVING_THROW_WILL;
            nSpellSaveFailVFX = VFX_IMP_HEAD_EVIL;
        break;
    }

    SetLocalInt(oNPC, "HF_SPELL_LEVEL", nSpellLevel);
    SetLocalInt(oNPC, "HF_SPELL_SAVE_TYPE", nSpellSaveType);
    SetLocalInt(oNPC, "HF_SPELL_SAVE_FAIL_VFX", nSpellSaveFailVFX);
}

// sets the index (SPELL_) spell level, and saving throw type of the current spell attempt
void SpellSetSpellNum(object oPC, object oNPC, int nSpell)
{
    SetLocalInt(oNPC, "HF_SPELL_NUM", nSpell);
}

// gets the index (SPELL_) of the current spell attempt
int SpellGetSpellNum(object oNPC)
{
    return(GetLocalInt(oNPC, "HF_SPELL_NUM"));
}

int SpellGetSpellLevel(object oNPC)
{
    return(GetLocalInt(oNPC, "HF_SPELL_LEVEL"));
}

int SpellGetSpellSaveType(object oNPC)
{
    return(GetLocalInt(oNPC, "HF_SPELL_SAVE_TYPE"));
}

// can the player cast this spell
int SpellCanCast(object oPC, int nSpell)
{
    return(GetHasSpell(nSpell, oPC));
}

// return the DC for this spell
int SpellGetDC(object oPC, object oNPC, int nSpell)
{
    int nAbilityModifier = GetLocalInt(oNPC, "HF_SPELL_ABILITY_MOD");
    int nSpellLevel = SpellGetSpellLevel(oNPC);

    //Check if DC has been overridden
    int nDC = GetLocalInt(oNPC, "HF_SPELL_DC");
    if (nDC <= 0)
    {
        nDC = GetLocalInt(GetModule(), "HF_SPELL_DC");
    }

    //Spell DC = 10 + spell level + ability modifier
    if (nDC <= 0)
    {
        nDC = 10;
    }

    nDC += nSpellLevel + nAbilityModifier;

    return(nDC);
}

// make the saving throw against the spell and return whether the spell was successful
int SpellMakeSavingThrow(object oNPC, int nDC, object oPC)
{
    int nSpellSaveType = GetLocalInt(oNPC, "HF_SPELL_SAVE_TYPE");
    int nSuccess = 0;

    string sNPCTag = GetLocalString(oNPC, "HF_SPELL_NPC_TAG");

    object oTarget;

    effect eSave;

    //Check whether an NPC tag has been supplied to make the saving throw
    //e.g. when a placeable is initiating the dialog on behalf on an NPC
    //such as an NPC behind a door
    if(sNPCTag != "")
    {
        oTarget = GetObjectByTag(sNPCTag);
        if(!GetIsObjectValid(oTarget))
        {
            oTarget = oNPC;
        }
    }
    else
    {
        oTarget = oNPC;
    }

    //Return whether the spell is successful, not the save
    if(nSpellSaveType == SAVING_THROW_REFLEX)
    {
        nSuccess = !ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_NONE, oPC);
        if(!nSuccess)
        {
            eSave = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
        }
    }
    else
    if(nSpellSaveType == SAVING_THROW_FORT)
    {
        nSuccess = !FortitudeSave(oTarget, nDC, SAVING_THROW_TYPE_NONE, oPC);
        if(!nSuccess)
        {
            eSave = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE);
        }
    }
    else
    {
        nSuccess = !WillSave(oTarget, nDC, SAVING_THROW_TYPE_NONE, oPC);
        if(!nSuccess)
        {
            eSave = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
        }
    }

    //If spell was successful, apply appropriate VFX, otherwise apply
    //the saving throw VFX
    if(nSuccess)
    {
        eSave = EffectVisualEffect(GetLocalInt(oNPC, "HF_SPELL_SAVE_FAIL_VFX"));
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSave, oNPC);

    return nSuccess;
}

// determine the DC of the spell and perform the saving throw
int SpellCheck(object oPC, object oNPC, int nSpell, int nPass=FALSE)
{
    int nSuccess;

    effect eSuccess = EffectVisualEffect(VFX_IMP_HEAD_MIND);
    effect eFail = EffectVisualEffect(VFX_IMP_HEAD_EVIL);

    // make the spell check
    if (!nPass)
    {
        // Get the DC of the saving throw against the spell
        int nDC = SpellGetDC(oPC, oNPC, nSpell);

        //Check the success of the spell by making a saving throw
        nSuccess = SpellMakeSavingThrow(oNPC, nDC, oPC);
    }
    else
    {
        // the spell check must automatically pass
        nSuccess = TRUE;
    }

    // give XP for a successful spell cast
    if (nSuccess)
    {
        if (!GetLocalInt(oNPC, "HF_SPELL_NO_XP"))
        {
            int nXP = GetLocalInt(oNPC, "HF_SPELL_XP");
            if (nXP <= 0)
            {
                nXP = GetLocalInt(GetModule(), "HF_SPELL_XP");
            }
            if (nXP > 0)
            {
                GiveXPToCreature(oPC, nXP);
            }
        }
        FloatingTextStringOnCreature("*** Success ***", oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSuccess, oPC);

        return TRUE;
    }
    else
    {
        // check failed
        FloatingTextStringOnCreature("*** Failed ***", oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail, oPC);
    }

    return FALSE;
}

//Automatic failure for a spell cast check
int SpellCheckFail(object oPC, object oNPC, int nSpell)
{
    effect eFail = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    FloatingTextStringOnCreature("*** Failed ***", oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail, oPC);

    return FALSE;
}

//Cast the spell, and store spell and caster information at the point it is
//available, namely directly after the spell has been cast
void SpellCastSpell(object oPC, object oNPC, int nSpell)
{
    AssignCommand(oPC, ActionPauseConversation());
    AssignCommand(oPC, ActionCastFakeSpellAtObject(nSpell, oNPC));
    AssignCommand(oPC, ActionDoCommand(SetCasterClass(oNPC)));
    AssignCommand(oPC, ActionDoCommand(SetCasterAbilityModifier(oPC, oNPC)));
    AssignCommand(oPC, ActionDoCommand(SpellSetSpellDetails(oNPC, nSpell)));
    AssignCommand(oPC, ActionDoCommand(DecrementRemainingSpellUses(oPC, nSpell)));
    AssignCommand(oPC, ActionResumeConversation());
    return;
}

/*
OBJECT:
  HF_SPELL_NUM : the spell number to use in this check
  HF_SPELL_XP : XP for all spell checks against this creature
  HF_SPELL_DC : base DC for all spell checks against this creature
  HF_SPELL_NPC_TAG : tag of an NPC to make saving throw on behalf of
                     object being conversed with, e.g guard behind door

MODULE:
  HF_SPELL_XP : default amount of XP given for successful spell checks
  HF_SPELL_DC : default base DC for all spell checks in the game
*/
