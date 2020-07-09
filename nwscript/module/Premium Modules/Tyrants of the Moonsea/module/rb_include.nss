#include "NW_I0_GENERIC"

void AppraiseFavOpenStore(object oStore, object oPC, int nBonusMarkUp = 0, int nBonusMarkDown = 0)
{
    int STATE_WON = 3;
    string sTag = ObjectToString(OBJECT_SELF);

    int nPlayerSkillRank = GetSkillRank(SKILL_APPRAISE, oPC);

    int nNPCSkillRank = 0;
    int nAdjust = 0;
    int nState = STATE_WON;
    int nPreviousRank = GetLocalInt(oPC, "X0_APPRAISERANK"+ sTag);

    // * if the player's rank has improved, let them have another appraise check
    // * against this merchant

    if ( (nPlayerSkillRank > nPreviousRank) || !GetLocalInt(oPC, "X0_APPRAISEVISITED"+sTag) )
    {
       SetLocalInt(oPC, "X0_APPRAISERANK"+ sTag, nPlayerSkillRank);
       SetLocalInt(oPC, "X0_APPRAISEVISITED"+sTag, 1);

       nPlayerSkillRank = nPlayerSkillRank + d10();
       nAdjust = nNPCSkillRank - nPlayerSkillRank; // * determines the level of price modification
    }
    else
    {
        // * recover last reaction
        nAdjust  = GetLocalInt(oPC, "X0_APPRAISEADJUST" + sTag);
    }

    FloatingTextStrRefOnCreature(8965, oPC, FALSE);

    SetLocalInt(oPC, "X0_APPRAISEADJUST"+ sTag, nAdjust);

    // * Hard cap of 1% to 30% down, i.e. always favourable
    if (nAdjust >= 0)
        nAdjust = -1;
    if (nAdjust < -30)
        nAdjust = -30;

    nBonusMarkUp = nBonusMarkUp + nAdjust;
    nBonusMarkDown = nBonusMarkDown - nAdjust;
    OpenStore(oStore, oPC, nBonusMarkUp, nBonusMarkDown);
}

void ChangeToWerewolf(object oLycan, object oEnemy)
{
    effect ePoly = EffectVisualEffect(VFX_IMP_POLYMORPH);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoly, oLycan);
    SetCreatureAppearanceType(oLycan, APPEARANCE_TYPE_WEREWOLF);
    ChangeToStandardFaction(oLycan,STANDARD_FACTION_HOSTILE);
    SetIsTemporaryEnemy(oEnemy, oLycan);
    AssignCommand(oLycan, DetermineCombatRound(oEnemy));
}

void ClearFollowersReputation(object oPC, object oTarget)
{
    int h = 1;
    int i;

    object oCreature;
    object oHench = GetHenchman(oPC, h);

    while(oHench != OBJECT_INVALID)
    {
        AssignCommand(oHench,ClearAllActions(TRUE));
        ClearPersonalReputation(oTarget,oHench);
        ClearPersonalReputation(oHench,oTarget);
        h++;
        oHench = GetHenchman(oPC, h);
    }

    for(i = ASSOCIATE_TYPE_ANIMALCOMPANION; i <= ASSOCIATE_TYPE_DOMINATED; i++)
    {
        oCreature = GetAssociate(i,oPC);
        if(oCreature != OBJECT_INVALID)
        {
            AssignCommand(oCreature,ClearAllActions(TRUE));
            ClearPersonalReputation(oTarget,oCreature);
            ClearPersonalReputation(oCreature,oTarget);
       }
    }
}

void RemoveAllEffects(object oCreature)
{
    effect eEffect = GetFirstEffect(oCreature);

    while(GetIsEffectValid(eEffect))
    {
       RemoveEffect(oCreature,eEffect);

       eEffect = GetNextEffect(oCreature);
    }
}

//Remove a named effect that was applied by a particular object
void RemoveNamedEffectByCreator(int iEffectID, object oCreature, object oCreator)
{
    effect eEffect = GetFirstEffect(oCreature);

    while(GetIsEffectValid(eEffect))
    {
       if(GetEffectType(eEffect) == iEffectID)
       {
           if(GetEffectCreator(eEffect) == oCreator)
           {
               RemoveEffect(oCreature,eEffect);
           }
       }
       eEffect = GetNextEffect(oCreature);
    }
}

void TakeSingleItem(object oTarget,string sItem)
{
    int iFound;

    object oItem = GetFirstItemInInventory(oTarget);

    while(GetIsObjectValid(oItem) && iFound == 0)
    {
        if(GetTag(oItem) == sItem)
        {
            iFound = 1;

            int iStack = GetNumStackedItems(oItem);

            if(iStack == 1)
            {
                DestroyObject(oItem);
            }
            else
            {
                SetItemStackSize(oItem,(iStack - 1));
            }
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}

/*void main()
{
} */
