// combat AI for gorgomorz (the big boss monster)

#include "nw_i0_generic"
#include "hf_in_graphics"
#include "x0_i0_position"
#include "hf_in_henchman"

void MyCastSpell(int nSpell, object oTarget, int nMetaMagic=METAMAGIC_ANY, int bCheat=FALSE, int nDomainLevel=0, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int bInstantSpell=FALSE);
void CastSpell(object oIntruder, int nClose = FALSE);

// is the game set to "difficult"?
int IsDifficult()
{
    return (GetGameDifficulty() == GAME_DIFFICULTY_CORE_RULES ||
            GetGameDifficulty() == GAME_DIFFICULTY_DIFFICULT);
}

// buff self up in case some outrageously high level player comes along
void BuffSelf()
{
    object oPC = GetFirstPC();
    int nDelta = GetHitDice(oPC) - 15;
    if (nDelta > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(50*nDelta), OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackIncrease(nDelta), OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSavingThrowIncrease(SAVING_THROW_ALL, nDelta/2), OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nDelta/3), OBJECT_SELF);
    }

    int nHenchmen = HenchmanCount(oPC);
    if (nHenchmen > 0)
    {
        int nBonusHits = nHenchmen * GetMaxHitPoints(OBJECT_SELF)/4;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(nBonusHits), OBJECT_SELF);
    }
}

// is this foe tough? weak foes aren't worth wasting spells on
int GetIsTough(object oFoe)
{
    return(GetHitDice(oFoe) >= 6);
}

// make a custom flame circle attack
void Flame(location lLoc, float fRadius)
{
    DrawCircle(GetLocation(OBJECT_SELF), fRadius, VFX_IMP_FLAME_M);
    object o = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(o))
    {
        if (!GetFactionEqual(o, OBJECT_SELF))
        {
            if (!ReflexSave(o, 15, SAVING_THROW_TYPE_FIRE, OBJECT_SELF))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), o);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6(2), DAMAGE_TYPE_FIRE), o);
            }
            if (!FortitudeSave(o, 12, SAVING_THROW_TYPE_SPELL, OBJECT_SELF))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), o, 3.0);
            }
        }
        o = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    }
}

// summon a barbazu friend
void SummonDevil(location lLoc)
{
    string sTag = "ks_gorgo_sum_1";
    object oFiend = CreateObject(OBJECT_TYPE_CREATURE, sTag, lLoc, FALSE, "_ar0100_gorgo_friend");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMONDRAGON), lLoc);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE), OBJECT_SELF);
    DrawLineVert(lLoc, VFX_IMP_FLAME_M);
    AssignCommand(oFiend, DetermineCombatRound());
}

// count the number of devil friends I have summoned
int CountDevils()
{
    int nCount = 1;
    object oDevil = GetNearestObjectByTag("_ar0100_gorgo_friend", OBJECT_SELF, 1);
    while (GetIsObjectValid(oDevil))
    {
        oDevil = GetNearestObjectByTag("_ar0100_gorgo_friend", OBJECT_SELF, ++nCount);
    }
    return(nCount-1);
}

// teleport visual effects
void TeleportVis(object oWP)
{
    effect eVis = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    location lLoc;
    vector vPos = GetPosition(oWP);
    float fDelay;
    int i;
    for(i = 1; i <= 26; i++)
    {
        vPos.z += 0.3;
        lLoc = Location(GetArea(OBJECT_SELF), vPos, 0.0);
        DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc));
        fDelay += 0.04;
    }
    DrawCircle(GetLocation(oWP), 3.0, VFX_IMP_NEGATIVE_ENERGY);
}

// teleport to a safe location
void Teleport(int bHeal, object oIntruder)
{
    effect eKnock = EffectKnockdown();
    int i = 1;
    int nDur;
    float fDistance;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, i);
    while(oCreature != OBJECT_INVALID)
    {
        fDistance = GetDistanceBetween(OBJECT_SELF, oCreature);
        if(fDistance > 10.0)
            break;
        nDur = d4(1);
        AssignCommand(oCreature, ClearAllActions());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oCreature, IntToFloat(nDur));
        i++;
        oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, i);
    }

    ClearAllActions();
    object oWP = GetNearestObjectByTag("WP_AR0100_GORGO_TELEPORT", OBJECT_SELF, d3());
    TeleportVis(OBJECT_SELF);
    JumpToObject(oWP);
    DelayCommand(1.0, TeleportVis(oWP));

    if(bHeal)
    {
        //SendMessageToPC(GetFirstPC(), "Wants to Heal");
        if(GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS))
        {
            DelayCommand(1.5, MyCastSpell(SPELL_CURE_CRITICAL_WOUNDS, OBJECT_SELF));
            // SendMessageToPC(GetFirstPC(), "Healed");
        }
        else
        {
            ActionAttack(oIntruder);
        }
    }
    else
    {
        //SendMessageToPC(GetFirstPC(), "DetComRd");
        DelayCommand(1.5, ActionAttack(oIntruder));
    }
}

// is the target near an existing AOE spell?
int NearAoe(object oIntruder)
{
    int nLocValid = GetLocalInt(OBJECT_SELF, "LOC_VALID");
    if(nLocValid == 0)
        return FALSE;
    location lLast = GetLocalLocation(OBJECT_SELF, "LAST_AOE");
    return (GetDistanceBetweenLocations(lLast, GetLocation(oIntruder)) <= 3.0);
}

// random VFX to make me look powerful
void DoVfx()
{
    int n = d100();
    if (n <= 30)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), OBJECT_SELF);
    }
}

void main()
{
    object oIntruder = GetLocalObject(OBJECT_SELF, "X2_NW_I0_GENERIC_INTRUDER");
    float fDistance = GetDistanceBetween(OBJECT_SELF, oIntruder);
    //SendMessageToPC(GetFirstPC(), "Intruder = " + GetName(oIntruder));

    // do we have a valid target?
    SetLocalInt(OBJECT_SELF,"X2_SPECIAL_COMBAT_AI_SCRIPT_OK", 1);
    if (GetIsObjectValid(oIntruder) == FALSE)
        oIntruder = bkAcquireTarget();

    fDistance = GetDistanceBetween(OBJECT_SELF, oIntruder);
    ClearAllActions();

    if(GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }

    if(GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetLastAttacker();
    }

    if (GetIsDead(oIntruder) == TRUE)
        return;
    if (!GetIsEnemy(oIntruder))
        return;
    if (__InCombatRound() == TRUE)
        return;
    __TurnCombatRoundOn(TRUE);

    // -----------------------------------------------------------------------
    // STEP1: do initial "fast" actions before combat begins
    // -----------------------------------------------------------------------

    if(GetLocalInt(OBJECT_SELF, "DO_INSTANT_ONCE") == 0)
    {
        SetLocalInt(OBJECT_SELF, "DO_INSTANT_ONCE", 1);
        ActionCastSpellAtObject(SPELLABILITY_AURA_FEAR, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
        ActionCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);

        /*if (IsDifficult())
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHaste(), OBJECT_SELF);
        } */

        object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR);
        itemproperty ipSilence = ItemPropertySpellImmunitySpecific(IP_CONST_IMMUNITYSPELL_SILENCE);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipSilence, oHide);

        BuffSelf();

        __TurnCombatRoundOn(FALSE);
        return;
    }

    // -----------------------------------------------------------------------
    // STEP2: do special custom things
    // -----------------------------------------------------------------------

    // if hurt, try to teleport away and heal
    int nTeleport = GetLocalInt(OBJECT_SELF, "TELEPORT");
    float fHP = IntToFloat(GetCurrentHitPoints()) / IntToFloat(GetMaxHitPoints());
    if(fHP < 0.5)
    {
        if(nTeleport == 0)
        {
            //SendMessageToPC(GetFirstPC(), "Teleport to heal");
            SetLocalInt(OBJECT_SELF, "TELEPORT", 1);
            Teleport(TRUE, oIntruder);
            DelayCommand(12.0, SetLocalInt(OBJECT_SELF, "TELEPORT", 0));
        }
        else
        {
            if(GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS))
            {
                //SendMessageToPC(GetFirstPC(), "No teleport Healed");
                MyCastSpell(SPELL_CURE_CRITICAL_WOUNDS, OBJECT_SELF);
            }
            else
            {
                ActionAttack(oIntruder);
            }
        }
        __TurnCombatRoundOn(FALSE);
        return;
    }

    // do some random VFX to make me look really powerful and dangerous
    DoVfx();

    // bring up a spell mantle
    if(GetHasSpell(SPELL_SPELL_MANTLE) && !GetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION))
    {
        ActionCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
        __TurnCombatRoundOn(FALSE);
        return;
    }

    // summon some devilish friends
    if(GetLocalInt(OBJECT_SELF, "nCanSummonDevil") == 0)
    {
        if (CountDevils() <= 2)
        {
            SetLocalInt(OBJECT_SELF, "nCanSummonDevil", 1);
            DelayCommand(40.0, DeleteLocalInt(OBJECT_SELF, "nCanSummonDevil"));
            SummonDevil(GetBehindLocation(oIntruder));
            __TurnCombatRoundOn(FALSE);
            return;
        }
    }

    // dispel magical protections
    if (GetHasSpell(SPELL_GREATER_DISPELLING))
    {
        if (GetIsTough(oIntruder))
        {
            ActionCastSpellAtObject(SPELL_GREATER_DISPELLING, oIntruder, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
            __TurnCombatRoundOn(FALSE);
            return;
        }
    }

    // stun weaker opponents
    if(GetHasSpell(SPELL_POWER_WORD_STUN))
    {
        if (GetIsTough(oIntruder) && GetCurrentHitPoints(oIntruder) <= 149)
        {
            ActionCastSpellAtObject(SPELL_POWER_WORD_STUN, oIntruder, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
            __TurnCombatRoundOn(FALSE);
            return;
        }
    }

    // cast hold person on rogues
    if (GetHasSpell(SPELL_HOLD_PERSON))
    {
        if (!GetHasSpellEffect(SPELL_HOLD_PERSON, oIntruder))
        {
            if (GetIsTough(oIntruder) && GetLevelByClass(CLASS_TYPE_ROGUE, oIntruder) > 0)
            {
                ActionCastSpellAtObject(SPELL_HOLD_PERSON, oIntruder, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
                __TurnCombatRoundOn(FALSE);
                return;
            }
        }
    }

    // flame on!
    if (GetLocalInt(OBJECT_SELF, "nCanFlame") == 0)
    {
        if (fDistance <= 10.0)
        {
            SetLocalInt(OBJECT_SELF, "nCanFlame", 1);
            DelayCommand(20.0, DeleteLocalInt(OBJECT_SELF, "nCanFlame"));
            Flame(GetLocation(OBJECT_SELF), 3.0);
            __TurnCombatRoundOn(FALSE);
            return;
        }
    }

    // cast invisibility on self
    if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY) &&
       !GetHasEffect(EFFECT_TYPE_INVISIBILITY) &&
       !GetHasEffect(EFFECT_TYPE_SPELLLEVELABSORPTION))
    {
        ActionCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY, OBJECT_SELF, METAMAGIC_NONE, FALSE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
        __TurnCombatRoundOn(FALSE);
        return;
    }

    // -----------------------------------------------------------------------
    // STEP 3: use range to decide if we should cast a spell or attack
    // -----------------------------------------------------------------------

    int nSpellPr = GetLocalInt(OBJECT_SELF, "SPELL_PRIORITY"); // spell priority (should be high at the beginning)
    int nRand = Random(100) + 1;
    nRand += nSpellPr;

    //SendMessageToPC(GetFirstPC(), "Distance = " + FloatToString(fDistance));
    if(fDistance < 6.0) // close range enemy
    {
        /*if(nRand <= 20 && IsDifficult())
        {
            ActionUseFeat(FEAT_KNOCKDOWN, oIntruder);
        }
        else*/
        if(nRand <= 30)
        {
            ActionUseFeat(FEAT_POWER_ATTACK, oIntruder);
        }
        else if(nRand <= 50)
        {
            ActionAttack(oIntruder);
        }
        else if(nRand <= 70 && nTeleport == 0)
        {
            SetLocalInt(OBJECT_SELF, "TELEPORT", 1);
            Teleport(FALSE, oIntruder);
            DelayCommand(12.0, SetLocalInt(OBJECT_SELF, "TELEPORT", 0));
        }
        else
        {
            CastSpell(oIntruder, TRUE);
            nSpellPr -= 10;
            SetLocalInt(OBJECT_SELF, "SPELL_PRIORITY", nSpellPr);
        }
        __TurnCombatRoundOn(FALSE);
        return;
    }
    else // long range enemy
    {
        if(nRand <= 10)
        {
            //SendMessageToPC(GetFirstPC(), "Distance less than 10, actionattack");
            ActionAttack(oIntruder);
        }
        else
        {
            CastSpell(oIntruder);
            nSpellPr -= 10;
            SetLocalInt(OBJECT_SELF, "SPELL_PRIORITY", nSpellPr);
        }
        __TurnCombatRoundOn(FALSE);
        return;
    }

   __TurnCombatRoundOn(FALSE);
}

void MyCastSpell(int nSpell, object oTarget, int nMetaMagic, int bCheat=FALSE, int nDomainLevel=0, int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT, int bInstantSpell=FALSE)
{
    //SendMessageToPC(GetFirstPC(), "BOOM: Casting: " + GetStringByStrRef(StringToInt(Get2DAString("spells", "Name", nSpell))));
    ActionCastSpellAtObject(nSpell, oTarget, nMetaMagic, bCheat, nDomainLevel, nProjectilePathType, bInstantSpell);
}

void CastSpell(object oIntruder, int bClose)
{
   float fDistance = GetDistanceBetween(oIntruder, OBJECT_SELF);
   int nRand = Random(100) + 1;

   // are we casting an AOE spell? don't cast another one near the last one
   if(nRand <= 40)
   {
       if(GetHasSpell(SPELL_INCENDIARY_CLOUD) && !NearAoe(oIntruder))
       {
            SetLocalLocation(OBJECT_SELF, "LAST_AOE", GetLocation(oIntruder));
            SetLocalInt(OBJECT_SELF, "LOC_VALID", 1);
            DelayCommand(60.0, DeleteLocalLocation(OBJECT_SELF, "LAST_AOE"));
            DelayCommand(60.0, DeleteLocalInt(OBJECT_SELF, "LOC_VALID"));
            MyCastSpell(SPELL_INCENDIARY_CLOUD, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
       }
       if(GetHasSpell(SPELL_WALL_OF_FIRE) && !NearAoe(oIntruder))
       {
            SetLocalLocation(OBJECT_SELF, "LAST_AOE", GetLocation(oIntruder));
            SetLocalInt(OBJECT_SELF, "LOC_VALID", 1);
            DelayCommand(60.0, DeleteLocalLocation(OBJECT_SELF, "LAST_AOE"));
            DelayCommand(60.0, DeleteLocalInt(OBJECT_SELF, "LOC_VALID"));
            MyCastSpell(SPELL_WALL_OF_FIRE, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
       }
       nRand = 75;
   }

   // are we casting a group spell?
   if(nRand <= 75)
   {
       if(GetHasSpell(SPELL_METEOR_SWARM))
       {
           MyCastSpell(SPELL_METEOR_SWARM, OBJECT_SELF);
           __TurnCombatRoundOn(FALSE);
           return;
       }
       if(GetHasSpell(SPELL_FIREBALL))
       {
            MyCastSpell(SPELL_FIREBALL, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
       }
       if(GetHasSpell(SPELL_FIRE_STORM))
       {
            MyCastSpell(SPELL_FIRE_STORM, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
       }
       nRand = 100;
   }

   // are we casting a single target spell?
   if(nRand <= 100)
   {
       if(GetHasSpell(SPELL_FLAME_STRIKE))
       {
            MyCastSpell(SPELL_FLAME_STRIKE, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
       }
       if(GetHasSpell(SPELLABILITY_BOLT_FIRE))
       {
            MyCastSpell(SPELLABILITY_BOLT_FIRE, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
       }
       if(GetHasSpell(SPELL_FIREBRAND))
       {
            MyCastSpell(SPELL_FIREBRAND, oIntruder);
            __TurnCombatRoundOn(FALSE);
            return;
       }
   }

    // we don't have any useful spells to cast, so just attack
    ActionAttack(oIntruder);
    __TurnCombatRoundOn(FALSE);
    return;
}
