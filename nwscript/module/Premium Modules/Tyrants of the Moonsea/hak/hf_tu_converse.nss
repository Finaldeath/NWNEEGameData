// place this script in the onEnter event of a generic trigger.
//
//   HF_NPC_TAG - nearby npc runs up and talks to player
//   HF_CONVERSATION - player talks to self using this conversation
//   HF_REPEATING - if set the conversation will trigger each time
//   HF_FREEZE_PLAYER - if set the player will be immobilized

#include "hf_in_npc"

// make sure that the player can actually talk
void RemoveNegativeEffects(object oPC)
{
    effect eBad = GetFirstEffect(oPC);
    while(GetIsEffectValid(eBad))
    {
        int nEffectType = GetEffectType(eBad);
        if (nEffectType == EFFECT_TYPE_BLINDNESS ||
            nEffectType == EFFECT_TYPE_CHARMED ||
            nEffectType == EFFECT_TYPE_CONFUSED ||
            nEffectType == EFFECT_TYPE_DAZED ||
            nEffectType == EFFECT_TYPE_DEAF ||
            nEffectType == EFFECT_TYPE_DOMINATED ||
            nEffectType == EFFECT_TYPE_ENTANGLE ||
            nEffectType == EFFECT_TYPE_FRIGHTENED ||
            nEffectType == EFFECT_TYPE_PARALYZE ||
            nEffectType == EFFECT_TYPE_PETRIFY ||
            nEffectType == EFFECT_TYPE_POLYMORPH ||
            nEffectType == EFFECT_TYPE_SILENCE ||
            nEffectType == EFFECT_TYPE_SLEEP ||
            nEffectType == EFFECT_TYPE_SLOW ||
            nEffectType == EFFECT_TYPE_STUNNED)
        {
            RemoveEffect(oPC, eBad);
        }
        eBad = GetNextEffect(oPC);
    }

    UnpossessFamiliar(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC));
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        RemoveNegativeEffects(oPC);
        if (GetLocalInt(OBJECT_SELF, "HF_FREEZE_PLAYER"))
        {
            FreezeCreature(oPC);
        }

        string sConvo = GetLocalString(OBJECT_SELF, "HF_CONVERSATION");
        if (sConvo != "")
        {
            AssignCommand(oPC, ClearAllActions(TRUE));
            AssignCommand(oPC, ActionStartConversation(oPC, sConvo, FALSE, FALSE));
        }

        string sTag = GetLocalString(OBJECT_SELF, "HF_NPC_TAG");
        if (sTag != "")
        {
            object oNPC = GetNearestObjectByTag(sTag, oPC);
            if (GetIsObjectValid(oNPC))
            {
                AssignCommand(oNPC, ClearAllActions(TRUE));
                AssignCommand(oNPC, ActionStartConversation(oPC, "", FALSE, FALSE));
            } else {
                SendMessageToPC(oPC, "ERROR: invalid NPC tag - " + sTag);
            }
        }

        if (!GetLocalInt(OBJECT_SELF, "HF_REPEATING"))
        {
            DestroyObject(OBJECT_SELF);
        }
    }
}
