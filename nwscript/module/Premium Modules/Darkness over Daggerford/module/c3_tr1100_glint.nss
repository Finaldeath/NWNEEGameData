// player searches near rocks in lonely barrens

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
        object oWP = GetWaypointByTag("WP_AR1100_SECRET_ARMOR");
        location lLoc = GetLocation(oWP);
        object oStone = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_secretglint_pl", lLoc);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionStartConversation(oStone, "", FALSE, FALSE));

        // trigger no longer useful
        DestroyObject(OBJECT_SELF);
    }
}

// search for the secret stone
void Search(object oPC)
{
    int nSkill = GetSkillRank(SKILL_SEARCH, oPC);
    if (nSkill + d20() >= 12)
    {
        RevealSecret(oPC);
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
