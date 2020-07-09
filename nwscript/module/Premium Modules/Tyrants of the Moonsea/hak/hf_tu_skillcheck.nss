// place this script in the onEnter event of a trigger.
// and set these variables on the trigger object
//
// HF_SKILL     - LISTEN | LORE | SEARCH | SPELLCRAFT | SPOT
// HF_SKILL_DC  - DC of skill to roll against
// HF_SKILL_XP  - XP to give if successful (uses module default too)
// HF_TEXT      - text to display if successful
// HF_ACTION    - script to run if successful
// HF_REPEATING - set to true if you want player to get more than one try

int GetSkillType(string sType)
{
    if (sType == "LISTEN") return SKILL_LISTEN;
    if (sType == "LORE") return SKILL_LORE;
    if (sType == "SEARCH") return SKILL_SEARCH;
    if (sType == "SPELLCRAFT") return SKILL_SPELLCRAFT;
    if (sType == "SPOT") return SKILL_SPOT;
    return 0;
}

string GetSkillName(int nType)
{
    if (nType == SKILL_LISTEN) return "Listen";
    if (nType == SKILL_LORE) return "Lore";
    if (nType == SKILL_SEARCH) return "Search";
    if (nType == SKILL_SPELLCRAFT) return "Spellcraft";
    if (nType == SKILL_SPOT) return "Spot";
    return "";
}

void PlaySkillSound(object oPC, int nType)
{
    if (nType == SKILL_SPOT) PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);
    if (nType == SKILL_LORE) AssignCommand(oPC, PlaySound("gui_magbag_full"));
    if (nType == SKILL_SEARCH) PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);
    if (nType == SKILL_SPELLCRAFT) AssignCommand(oPC, PlaySound("gui_magbag_full"));
    if (nType == SKILL_SPOT) PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) && !GetLocalInt(OBJECT_SELF, "nDone"))
    {
        if (!GetIsInCombat(oPC))
        {
            int nSkill = GetSkillType(GetLocalString(OBJECT_SELF, "HF_SKILL"));
            int nDC = GetLocalInt(OBJECT_SELF, "HF_SKILL_DC");
            if ((d20() + GetSkillRank(nSkill, oPC)) >= nDC)
            {
                // roll was successful
                SetLocalInt(OBJECT_SELF, "nDone", 1);
                string sText = GetSkillName(nSkill) + ": " + GetLocalString(OBJECT_SELF, "HF_TEXT");
                AssignCommand(oPC, ClearAllActions());
                PlaySkillSound(oPC, nSkill);
                FloatingTextStringOnCreature("... " + GetSkillName(nSkill) + " Skill Check: Success ...", oPC);
                DelayCommand(1.25, AssignCommand(oPC, SpeakString(sText)));

                // give XP to player
                int nXP = GetLocalInt(OBJECT_SELF, "HF_SKILL_XP");
                if (nXP == 0)
                    nXP = GetLocalInt(GetModule(), "HF_SKILL_XP");
                if (nXP > 0)
                    GiveXPToCreature(oPC, nXP);

                // execute a custom action
                string sScript = GetLocalString(OBJECT_SELF, "HF_ACTION");
                if (sScript != "")
                {
                    DelayCommand(1.5, ExecuteScript(sScript, oPC));
                }
            } else {
                // roll was failed
                if (GetLocalInt(OBJECT_SELF, "HF_REPEATING") == 0)
                {
                    SetLocalInt(OBJECT_SELF, "nDone", 1);
                }
            }
        } else {
            // when in combat, skill checks always fail
            if (GetLocalInt(OBJECT_SELF, "HF_REPEATING") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nDone", 1);
            }
        }
    }
}

