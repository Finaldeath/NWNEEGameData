#include "inc_tagconstants"
#include "inc_variables"
#include "inc_strings"
#include "_inc_cutscene"
/* _inc_cutscene includes the following:
      _inc_cut_level1
      _inc_cut_level2
      _inc_cut_misc
      _inc_generic
      _inc_array
*/
#include "nw_i0_plot"
#include "inc_polyflee"

// Function declarations
////////////////////////

// simply heals oCreature to full health
void HealFull(object oCreature=OBJECT_SELF);

// used in Act 2, beneath temple
void A2UnderTempleArraySetup(object oArea);

// exactly like cs_StartCutscene(), except it'll take care of Poly
void cs_StartCutscene_Poly(string sCSScript, string sEndScript="", float fDelay=0.0, int bAbortable=FALSE, int bRemoveAOEs=TRUE, int nCutNumber=1, object oArea=OBJECT_SELF);

// exactly like cs_AreaOnEnter(), except it'll take care of Poly
void cs_AreaOnEnter_Poly(object oEnterer);

// This is used when playing animations for the player's crew in Act 3 cutscenes.
// Certain models can't play some animations, and will screw up if said animations
// are called on those models. This function will check for such calls and ignore them.
// IMPORTANT: Only the following animations have been verified with this function.
// ANIMATION_LOOPING_SIT_CROSS, ANIMATION_LOOPING_LISTEN, ANIMATION_LOOPING_GET_LOW,
// ANIMATION_LOOPING_TALK_NORMAL, ANIMATION_LOOPING_LOOK_FAR, ANIMATION_FIREFORGET_HEAD_TURN_LEFT,
// ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,
// ANIMATION_FIREFORGET_PAUSE_BORED, ANIMATION_LOOPING_PAUSE_TIRED, ANIMATION_FIREFORGET_VICTORY*
void cs_ActionPlayAnimation_SafeForCrew(float fDelay, object oObject, int nAnimation, float fSpeed=1.0, float fDuration=0.0, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1);

// This is used when playing animations for the player's crew in Act 3.
// Certain models can't play some animations, and will screw up if said animations
// are called on those models. This function will check for such calls and ignore them.
// Note: No AssignCommand is needed with this version of the function.
// IMPORTANT: Only the following animations have been verified with this function.
// ANIMATION_LOOPING_SIT_CROSS, ANIMATION_LOOPING_LISTEN, ANIMATION_LOOPING_GET_LOW,
// ANIMATION_LOOPING_TALK_NORMAL, ANIMATION_LOOPING_LOOK_FAR, ANIMATION_FIREFORGET_HEAD_TURN_LEFT,
// ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,
// ANIMATION_FIREFORGET_PAUSE_BORED, ANIMATION_LOOPING_PAUSE_TIRED, ANIMATION_FIREFORGET_VICTORY*
void PlayAnimation_SafeForCrew(object oObject, int nAnimation, float fSpeed=1.0, float fSeconds=0.0);

// used by cs_ActionPlayAnimation_SafeForCrew() and PlayAnimation_SafeForCrew()
int GetIsAnimationSafeForCrew(int nAnimation, string sTag);

// Function implementations
///////////////////////////
void HealFull(object oCreature=OBJECT_SELF)
{
    int nCurrentHP = GetCurrentHitPoints(oCreature);
    int nMaxHP = GetMaxHitPoints(oCreature);
    int nHeal = nMaxHP - nCurrentHP;
    if(nHeal>0)
    {
        effect eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCreature);
    }
}

// used in Act 2, beneath temple
void A2UnderTempleArraySetup(object oArea)
{
    int nPriestessCount = 0;
    int nSahClericCount = 0;
    int nSahGuardCount = 0;

    object oCreature = GetObjectByTagInArea(a2c_tag_Priestess, oArea, 0);
    while(GetIsObjectValid(oCreature))
    {
        SetObjectArray(oArea, l_oa_A2_TEMPLE_PRIESTESS_ARRAY, nPriestessCount, oCreature);
        nPriestessCount++;
        oCreature = GetObjectByTagInArea(a2c_tag_Priestess, oArea, nPriestessCount);
    }
    SetLocalInt(oArea, l_n_A2_TEMPLE_PRIESTESS_COUNT, nPriestessCount);

    oCreature = GetObjectByTagInArea(a2c_tag_Sahuagin_Cleric, oArea, 0);
    while(GetIsObjectValid(oCreature))
    {
        SetObjectArray(oArea, l_oa_A2_TEMPLE_SAHCLERIC_ARRAY, nSahClericCount, oCreature);
        nSahClericCount++;
        oCreature = GetObjectByTagInArea(a2c_tag_Sahuagin_Cleric, oArea, nSahClericCount);
    }
    SetLocalInt(oArea, l_n_A2_TEMPLE_SAHCLERIC_COUNT, nSahClericCount);

    oCreature = GetObjectByTagInArea(a2c_tag_Sahuagin_Guard, oArea, 0);
    while(GetIsObjectValid(oCreature))
    {
        SetObjectArray(oArea, l_oa_A2_TEMPLE_SAHGUARD_ARRAY, nSahGuardCount, oCreature);
        nSahGuardCount++;
        oCreature = GetObjectByTagInArea(a2c_tag_Sahuagin_Guard, oArea, nSahGuardCount);
    }
    SetLocalInt(oArea, l_n_A2_TEMPLE_SAHGUARD_COUNT, nSahGuardCount);

    int i;
    for(i=0; i < (nPriestessCount+nSahClericCount+nSahGuardCount); i++)
    {
        if(i < nPriestessCount) oCreature = GetObjectArray(oArea, l_oa_A2_TEMPLE_PRIESTESS_ARRAY, i);
        else if(i < (nPriestessCount+nSahClericCount)) oCreature = GetObjectArray(oArea, l_oa_A2_TEMPLE_SAHCLERIC_ARRAY, i-nPriestessCount);
        else oCreature = GetObjectArray(oArea, l_oa_A2_TEMPLE_SAHGUARD_ARRAY, i-nPriestessCount-nSahClericCount);

        SetObjectArray(oArea, l_oa_A2_TEMPLE_ALL_ARRAY, i, oCreature);
    }
    SetLocalInt(oArea, l_n_A2_TEMPLE_ALL_COUNT, nPriestessCount+nSahClericCount+nSahGuardCount);
}

// exactly like cs_StartCutscene(), except it'll take care of Poly
void cs_StartCutscene_Poly(string sCSScript, string sEndScript="", float fDelay=0.0, int bAbortable=FALSE, int bRemoveAOEs=TRUE, int nCutNumber=1, object oArea=OBJECT_SELF)
{
    object oPoly = GetObjectByTagInArea(a1c_tag_Poly, GetArea(OBJECT_SELF));
    effect e = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oPoly, 10.0);
    PolyFlee(oPoly, TRUE);
    cs_StartCutscene(sCSScript, sEndScript, fDelay, bAbortable, bRemoveAOEs, nCutNumber, oArea);
}

// exactly like cs_AreaOnEnter(), except it'll take care of Poly
void cs_AreaOnEnter_Poly(object oEnterer)
{
    if(GetTag(oEnterer)==a1c_tag_Poly)
    {
        if(cs_GetCutsceneRunning())
        {
            effect e = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oEnterer, 10.0);
            PolyFlee(oEnterer, TRUE);
        }
    }
    cs_AreaOnEnter(oEnterer);
}

void cs_ActionPlayAnimation_SafeForCrew(float fDelay, object oObject, int nAnimation, float fSpeed=1.0, float fDuration=0.0, int bApplyOnAbort=FALSE, object oArea=OBJECT_SELF, int nCutNumber=-1)
{
    if(GetIsAnimationSafeForCrew(nAnimation, GetTag(oObject)))
    {
        cs_ActionPlayAnimation(fDelay, oObject, nAnimation, fSpeed, fDuration, bApplyOnAbort, oArea, nCutNumber);
    }
}

void PlayAnimation_SafeForCrew(object oObject, int nAnimation, float fSpeed=1.0, float fSeconds=0.0)
{
    if(GetIsAnimationSafeForCrew(nAnimation, GetTag(oObject)))
    {
        AssignCommand(oObject, PlayAnimation(nAnimation, fSpeed, fSeconds));
    }
}

int GetIsAnimationSafeForCrew(int nAnimation, string sTag)
{
    int bSafe = TRUE;
    switch(nAnimation)
    {
        // the commented ones seem to work ok - even if the model doesn't play the anim,
        // at least it doesn't screw up
        //case ANIMATION_FIREFORGET_HEAD_TURN_LEFT:
        //case ANIMATION_FIREFORGET_HEAD_TURN_RIGHT:
        //case ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD:
        //case ANIMATION_FIREFORGET_PAUSE_BORED:
        //case ANIMATION_LOOPING_PAUSE_TIRED:
        //case ANIMATION_FIREFORGET_VICTORY1:
        //case ANIMATION_FIREFORGET_VICTORY2:
        //case ANIMATION_FIREFORGET_VICTORY3:
        //    break;
        case ANIMATION_LOOPING_LISTEN:
            if(sTag=="a3_redtip" || sTag=="a3_redtip_dead") bSafe = FALSE;
            break;
        case ANIMATION_LOOPING_LOOK_FAR:
        case ANIMATION_LOOPING_SIT_CROSS:
        case ANIMATION_LOOPING_GET_LOW:
        case ANIMATION_LOOPING_TALK_NORMAL:
        case ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD:
        case ANIMATION_FIREFORGET_PAUSE_BORED:
            if(sTag=="a3_redtip" || sTag=="a3_redtip_dead" || sTag=="a3_langer2_dead" ||
               sTag=="a3_shakey_dead" || sTag=="a3_vantab_dead") bSafe = FALSE;
            break;
    }
    return bSafe;

}
