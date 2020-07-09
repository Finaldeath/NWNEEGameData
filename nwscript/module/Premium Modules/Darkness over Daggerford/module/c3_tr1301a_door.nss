// player searches near bhaal's symbol in temple
// - can only find it after speaking with xatuum

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

        // create the secret stone and interact with it
        object oWP = GetWaypointByTag("WP_AR1301A_STONE");
        location lLoc = GetLocation(oWP);
        object oStone = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_secretstone_pl", lLoc);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionStartConversation(oStone, "", FALSE, FALSE));

        // trigger no longer useful
        DestroyObject(OBJECT_SELF);
    }
}

// search for the secret flagstone
// .. can only find it if xatuum has been talked to (or is dead)
void Search(object oPC)
{
    object oXatuum = GetNearestObjectByTag("ks_xatuum", oPC);

    if (!GetIsObjectValid(oXatuum) || GetIsDead(oXatuum) || PlotLevelGet("ks_xatuum") >= 1)
    {
        int nSkill = GetSkillRank(SKILL_SEARCH, oPC);
        if (nSkill + d20() >= 15)
        {
            RevealSecret(oPC);
        }
        else
        {
            PlaySound("as_dr_stonmedcl1");
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
