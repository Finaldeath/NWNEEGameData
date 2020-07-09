//::///////////////////////////////////////////////
//::
//:: a3_ds_bw_daltar
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Disturbed script for placeable.
//:: Illefarn altar may accept a special item...
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/7/2005
//::
//:://////////////////////////////////////////////

void FakeRestore(object oTarget);

void main()
{
    int nType = GetInventoryDisturbType();

    if (nType == INVENTORY_DISTURB_TYPE_ADDED)
    {
        object oItem = GetInventoryDisturbItem();
        string sTag = GetTag(oItem);
        if (sTag == "bw_moradinstone")
        {
            SetPlotFlag(oItem, FALSE);
            DestroyObject(oItem, 0.2);

            effect eVFX = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);

            object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, TRUE);
            FakeRestore(oPC);

            object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,1);
            object oHenchman2 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,2);
            object oHenchman3 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,3);
            object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
            object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
            object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);
            object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);

            if(GetIsObjectValid(oHenchman))
            {
                ActionDoCommand(FakeRestore(oHenchman));
            }
            if(GetIsObjectValid(oHenchman2))
            {
                ActionDoCommand(FakeRestore(oHenchman2));
            }
            if(GetIsObjectValid(oHenchman3))
            {
                ActionDoCommand(FakeRestore(oHenchman3));
            }
            if(GetIsObjectValid(oAnimal))
            {
                ActionDoCommand(FakeRestore(oAnimal));
            }
            if(GetIsObjectValid(oFamiliar))
            {
                ActionDoCommand(FakeRestore(oFamiliar));
            }
            if(GetIsObjectValid(oDominated))
            {
                ActionDoCommand(FakeRestore(oDominated));
            }
            if(GetIsObjectValid(oSummoned))
            {
                ActionDoCommand(FakeRestore(oSummoned));
            }

            SetLocalInt(GetModule(), "nIH_RestoredStone", 1);
        }
    }
}

void FakeRestore(object oTarget)
{
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
        {
            //Remove effect if it is negative.
            RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        //Apply the VFX impact and effects
        int nHeal = GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget);
        effect eHeal = EffectHeal(nHeal);
//        if (nHeal > 0)
//            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        // Mar 2, 2004: Always heal at least one hp. Otherwise, if you have the wounding effect
        // but are at max hp (because of regeneration or whatever), the wounding will not
        // be removed.
        if(nHeal<1) nHeal=1;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}
