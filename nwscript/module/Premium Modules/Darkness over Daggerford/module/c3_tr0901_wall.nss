// player searches near wall for bloodstone
// - can only find something if stegil is spawned and dead
// - will always find it if feynemonee told us where to look

#include "hf_in_plot"

// the secret hiding place has been found!
void RevealSecret(object oPC)
{
    if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        // the door has been found
        FloatingTextStringOnCreature("... Search: Success! ...", oPC);
        PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);

        // create the secret vault and interact with it
        object oWP = GetWaypointByTag("WP_AR0901_SECRET_SAFE");
        object oSafe = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_secretsafe_pl", GetLocation(oWP));
        effect eVis = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oSafe, 10.0);
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.5, AssignCommand(oPC, ActionStartConversation(oSafe, "", FALSE, FALSE)));

        // trigger no longer useful
        DestroyObject(OBJECT_SELF);
    }
}

// search for the secret hiding place
// ... will always find it if Feynemonee told us where to look
void Search(object oPC)
{
    if (PlotLevelGet("ks_feynemonee") >= 1)
    {
        // feynemonee told us where to look
        RevealSecret(oPC);
    }
    else
    {
        // roll a search check
        int nSkill = GetSkillRank(SKILL_SEARCH, oPC);
        if (nSkill + d20() >= 15)
        {
            RevealSecret(oPC);
        }
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        Search(oPC);
    }
}
