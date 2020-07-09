// floor trigger for single use placeable spawn if a skill check is passed.
// these skill checks always repeat until found.
//
// HF_SECRET_SKILL - LISTEN | LORE | SEARCH | SPELLCRAFT | SPOT
// HF_SECRET_DC - skill difficulty roll target
// HF_SECRET_PLC - resref of placeable to spawn on success
// HF_SECRET_WP - waypoint where placeable will be spawned
// HF_SECRET_AUTO_RACE_1 - players of this racial type automatically succeed
// HF_SECRET_AUTO_CLASS_1 - players of this class type automatically succeed
// HF_SECRET_XP  - XP to give if successful (uses module default too)
// HF_SECRET_ITEM - item to be given to player during the plc conversation
// HF_SECRET_SOUND - pickup sound to play when item is taken
// HF_SECRET_ANIM - LOW | MID | READ | DRINK - played on pickup
// HF_SECRET_ALIGNMENT_GOOD - adjust player's alignment by an amount
// HF_SECRET_ALIGNMENT_EVIL - adjust player's alignment by an amount
// HF_SECRET_ALIGNMENT_LAWFUL - adjust player's alignment by an amount
// HF_SECRET_ALIGNMENT_CHAOTIC - adjust player's alignment by an amount

// returns the player's race as a string
string GetPlayerRace(object oPC)
{
    int nRace = GetRacialType(oPC);
    if (nRace == RACIAL_TYPE_HUMAN) return "human";
    if (nRace == RACIAL_TYPE_ELF) return "elf";
    if (nRace == RACIAL_TYPE_DWARF) return "dwarf";
    if (nRace == RACIAL_TYPE_GNOME) return "gnome";
    if (nRace == RACIAL_TYPE_HALFELF) return "halfelf";
    if (nRace == RACIAL_TYPE_HALFLING) return "halfling";
    if (nRace == RACIAL_TYPE_HALFORC) return "halforc";
    return "none";
}

// returns the player's level in the given class
int GetPlayerLevel(object oPC, string sClassName)
{
    string sClass = GetStringLowerCase(sClassName);
    if (sClass == "barbarian") return GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC);
    if (sClass == "bard") return GetLevelByClass(CLASS_TYPE_BARD, oPC);
    if (sClass == "cleric") return GetLevelByClass(CLASS_TYPE_CLERIC, oPC);
    if (sClass == "druid") return GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    if (sClass == "fighter") return GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
    if (sClass == "monk") return GetLevelByClass(CLASS_TYPE_MONK, oPC);
    if (sClass == "paladin") return GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    if (sClass == "ranger") return GetLevelByClass(CLASS_TYPE_RANGER, oPC);
    if (sClass == "rogue") return GetLevelByClass(CLASS_TYPE_ROGUE, oPC);
    if (sClass == "sorcerer") return GetLevelByClass(CLASS_TYPE_SORCERER, oPC);
    return 0;
}

// returns the player's skill rank in the given skill
int GetPlayerSkillRank(object oPC, string sSkillName)
{
    string sSkill = GetStringLowerCase(sSkillName);
    if (sSkill == "search") return GetSkillRank(SKILL_SEARCH, oPC);
    if (sSkill == "listen") return GetSkillRank(SKILL_LISTEN, oPC);
    if (sSkill == "spot") return GetSkillRank(SKILL_SPOT, oPC);
    if (sSkill == "spellcraft") return GetSkillRank(SKILL_SPELLCRAFT, oPC);
    if (sSkill == "lore") return GetSkillRank(SKILL_LORE, oPC);
    return 0;
}

// returns true if the player automatically succeeds based on race or class
int IsAutomaticSuccess(object oPC)
{
    int i;
    string sPlayerRace = GetPlayerRace(oPC);
    for (i = 1; i < 9; i++)
    {
        string sAutoRace = GetLocalString(OBJECT_SELF, "HF_SECRET_AUTO_RACE_" + IntToString(i));
        if (sPlayerRace == GetStringLowerCase(sAutoRace))
        {
            return TRUE;
        }
    }

    for (i = 1; i < 9; i++)
    {
        string sAutoClass = GetLocalString(OBJECT_SELF, "HF_SECRET_AUTO_CLASS_" + IntToString(i));
        if (GetPlayerLevel(oPC, sAutoClass) > 0)
        {
            return TRUE;
        }
    }
    return FALSE;
}

// the secret has been found!
void RevealSecret(object oPC, string sSkillName)
{
    if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        // the secret has been found
        FloatingTextStringOnCreature("** " + sSkillName + ": Success! **", oPC);
        PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);

        // create the secret placeable and interact with it
        string sWP = GetLocalString(OBJECT_SELF, "HF_SECRET_WP");
        object oWP = GetWaypointByTag(sWP);
        location lLoc = GetLocation(oWP);
        string sResRef = GetLocalString(OBJECT_SELF, "HF_SECRET_PLC");
        object oPlc = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
        if (GetIsObjectValid(oPlc))
        {
            string sItem = GetLocalString(OBJECT_SELF, "HF_SECRET_ITEM");
            SetLocalString(oPlc, "HF_SECRET_ITEM", sItem);
            string sSound = GetLocalString(OBJECT_SELF, "HF_SECRET_SOUND");
            SetLocalString(oPlc, "HF_SECRET_SOUND", sSound);
            string sAnim = GetLocalString(OBJECT_SELF, "HF_SECRET_ANIM");
            SetLocalString(oPlc, "HF_SECRET_ANIM", sAnim);
            int nGood = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_GOOD");
            SetLocalInt(oPlc, "HF_SECRET_ALIGNMENT_GOOD", nGood);
            int nEvil = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_EVIL");
            SetLocalInt(oPlc, "HF_SECRET_ALIGNMENT_EVIL", nEvil);
            int nLawful = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_LAWFUL");
            SetLocalInt(oPlc, "HF_SECRET_ALIGNMENT_LAWFUL", nLawful);
            int nChaotic = GetLocalInt(OBJECT_SELF, "HF_SECRET_ALIGNMENT_CHAOTIC");
            SetLocalInt(oPlc, "HF_SECRET_ALIGNMENT_CHAOTIC", nChaotic);

            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, ActionStartConversation(oPlc, "", FALSE, FALSE));
        }

        // give XP to player
        int nXP = GetLocalInt(OBJECT_SELF, "HF_SECRET_XP");
        if (nXP == 0)
            nXP = GetLocalInt(GetModule(), "HF_SKILL_XP");
        if (nXP > 0)
            GiveXPToCreature(oPC, nXP);

        // trigger no longer useful
        DestroyObject(OBJECT_SELF);
    }
}

// search for the secret using the appropriate skill
void Search(object oPC)
{
    int nSuccess = FALSE;

    string sSkill = GetLocalString(OBJECT_SELF, "HF_SECRET_SKILL");
    int nDC = GetLocalInt(OBJECT_SELF, "HF_SECRET_DC");
    int nSkill = GetPlayerSkillRank(oPC, sSkill);
    if (nSkill + d20() >= nDC)
    {
        nSuccess = TRUE;
    }

    if (IsAutomaticSuccess(oPC))
    {
        nSuccess = TRUE;
    }

    if (nSuccess)
    {
        RevealSecret(oPC, sSkill);
    }
}

// is the player able to search now?
int IsSearchPossible(object oPC)
{
    if (GetIsInCombat(oPC))
        return FALSE;
    if (GetCutsceneMode(oPC))
        return FALSE;
    if (IsInConversation(oPC))
        return FALSE;
    return TRUE;
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (IsSearchPossible(oPC))
        {
            Search(oPC);
        }
    }
}
