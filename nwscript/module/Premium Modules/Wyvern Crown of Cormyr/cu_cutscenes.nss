// Ben W-Husey (B G P Hughes)
// This is the include file for cutscene functions.
/*
Functions included are:
    ClearEffects            Remove cutscene busting effects.
    ClearForCut             Remove any effects on the PC that could bust the cutscene. Do the same for henchmen.

*/
#include "cu_functions"
//===========Delarations

//This function is used to clear negative effects from a character
// Inputs are:  oCharacter     The character to clean
void ClearEffects(object oCharacter);

// PC and up to 4 henchmen are set up for cutscene
// Inputs are:  oPC     The PC
void ClearForCut(object oPC);

// oTalker says sLine, with standard animation playing for fTime.
// nClear = TRUE then ClearAllActions first
void TalkNormal(object oTalker,string sLine, float fTime,int nClear=FALSE);

// oTalker says sLine, with forceful animation playing for fTime
// nClear = TRUE then ClearAllActions first
void TalkForce(object oTalker,string sLine, float fTime,int nClear=FALSE);

//==============end declarations=====================


//This function is used to clear negative effects from a character
// Inputs are:  oCharacter     The character to clean
void ClearEffects(object oCharacter)
{
        effect eEffect = GetFirstEffect(oCharacter);
        //Search for negative effects that might bust cutscenes
        while(GetIsEffectValid(eEffect))
        {
            if (GetEffectType(eEffect) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH ||
                GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eEffect) == EFFECT_TYPE_CHARMED ||
                GetEffectType(eEffect) == EFFECT_TYPE_CONFUSED ||
                GetEffectType(eEffect) == EFFECT_TYPE_DAZED ||
                GetEffectType(eEffect) == EFFECT_TYPE_DOMINATED ||
                GetEffectType(eEffect) == EFFECT_TYPE_FRIGHTENED ||
                GetEffectType(eEffect) == EFFECT_TYPE_PETRIFY ||
                GetEffectType(eEffect) == EFFECT_TYPE_SLOW ||
                GetEffectType(eEffect) == EFFECT_TYPE_STUNNED ||
                GetEffectType(eEffect) == EFFECT_TYPE_TIMESTOP)
                {
               //Remove the effect
                RemoveEffect(oCharacter, eEffect);
                }
            eEffect = GetNextEffect(oCharacter);
        }

}

// PC and up to 4 henchmen are set up for cutscene
// Inputs are:  oPC     The PC
void ClearForCut(object oPC)
{
        UnpossessFamiliar(oPC);
        AssignCommand(oPC,StoreCameraFacing());
        object oCharacter = oPC;
        ClearEffects(oCharacter);
        oCharacter = ReturnHenchman(oPC,1);
        if (GetIsObjectValid(oCharacter))  {ClearEffects(oCharacter);}
        oCharacter = ReturnHenchman(oPC,2);
        if (GetIsObjectValid(oCharacter))  {ClearEffects(oCharacter);}
        oCharacter = ReturnHenchman(oPC,3);
        if (GetIsObjectValid(oCharacter))  {ClearEffects(oCharacter);}
        oCharacter = ReturnHenchman(oPC,4);
        if (GetIsObjectValid(oCharacter))  {ClearEffects(oCharacter);}
}

void TalkNormal(object oTalker,string sLine, float fTime=1.0, int nClear=FALSE)
{
    if (nClear==TRUE) AssignCommand(oTalker,ClearAllActions(TRUE));
    AssignCommand(oTalker,SpeakString(sLine));
    AssignCommand(oTalker,ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,1.0,fTime));
}

void TalkForce(object oTalker,string sLine, float fTime=1.0, int nClear=FALSE)
{
    if (nClear==TRUE) AssignCommand(oTalker,ClearAllActions(TRUE));
    AssignCommand(oTalker,SpeakString(sLine));
    AssignCommand(oTalker,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,fTime));
}


