// Brian Watson

#include "NW_I0_GENERIC"

void JumpPCs();

void main()
{
    if (GetLocalInt(OBJECT_SELF, "nPorted") == 0)
    {
        ClearAllActions();

        effect eVanish = EffectVisualEffect(VFX_IMP_UNSUMMON);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVanish, OBJECT_SELF);

        // special cases
        if (GetTag(OBJECT_SELF) == "bw_beholder_n") // 'neutral' beholder
        {
            object oTrogs = GetObjectByTag("f_trogs");

            int nNth = 1;
            object oTrog = GetNearestObjectByTag("bw_trog01", OBJECT_SELF, nNth);
            while (GetIsObjectValid(oTrog))
            {
                if (GetLocalInt(OBJECT_SELF, "nAlliance") == 0)
                {
                    ChangeToStandardFaction(oTrog, STANDARD_FACTION_HOSTILE);
                    AssignCommand(oTrog, DetermineCombatRound());
                }
                else
                {
                    ChangeFaction(oTrog, oTrogs);
                }
                nNth += 1;
                oTrog = GetNearestObjectByTag("bw_trog01", OBJECT_SELF, nNth);
            }

            if (GetLocalInt(OBJECT_SELF, "nAlliance") == 1)
            {
                DelayCommand(0.5, JumpPCs());
            }
        }

        DestroyObject(OBJECT_SELF, 0.8);

        SetLocalInt(OBJECT_SELF, "nPorted", 1);
    }
}

void JumpPCs()
{
    object oWP = GetObjectByTag("wp_ar2505a_entry");
    location lWP = GetLocation(oWP);

    int nNth = 1;
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nNth, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);

    AddJournalQuestEntry("j19", 1, oPC);

    while (GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToLocation(lWP));
        nNth += 1;
        oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nNth, CREATURE_TYPE_IS_ALIVE, TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL);
    }
}
