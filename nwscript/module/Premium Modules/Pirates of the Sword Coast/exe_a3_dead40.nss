//::///////////////////////////////////////////////
//:: exe_a3_dead40
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The captain has made the PC undead as well as
    the crew of the. The only strange part is
    that the PC isn't under the control of the
    Captain, like all the others.

    A battle begins and the PC must fight for his
    Un-Life or be destroyed.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_undead"
#include "nw_i0_generic"

void main()
{
    object oPC = GetFirstPC();
    object oModule = GetModule();
    object oKolmarr = GetObjectByTag("a3_necro_fight");
    object oNisar = GetObjectByTag("a2_hench_nisar");
    object oGarm = GetObjectByTag("a1_hench_garm");
    object oNPC = OBJECT_INVALID;

    effect eVFX = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    string sMonster = "NECRO_MONSTER";
    int iDoOnce = GetLocalInt(oModule, "exe_a3_dead40");
    int iEXP = GetJournalQuestExperience("a3_dead");
    int iCounter = 0;

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "exe_a3_dead40", TRUE);

        //HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A3_DEAD", 40);
        AddJournalQuestEntry("a3_dead", 40, oPC);

        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC) == TRUE)
        {
            MakeUndead(oPC);
            DelayCommand(0.5f, ApplyVFXEyes(oPC));
            oPC = GetNextPC();
        }

        DelayCommand(0.5f, MakeUndead(oNisar));
        DelayCommand(0.5f, MakeUndead(oGarm));
        SetAssociateState(NW_ASC_HEAL_AT_25, FALSE, oGarm);
        SetAssociateState(NW_ASC_HEAL_AT_50, FALSE, oGarm);
        SetAssociateState(NW_ASC_HEAL_AT_75, FALSE, oGarm);

        DelayCommand(0.5f, ChangeToStandardFaction(oKolmarr, STANDARD_FACTION_HOSTILE));
        DelayCommand(1.3f, AssignCommand(oKolmarr, DetermineCombatRound(oPC)));

        while (iCounter < 5)
        {
            sMonster = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter+1));
            oNPC = GetObjectByTag(sMonster);

            DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oNPC));
            DelayCommand(0.6f, ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE));
            DelayCommand(1.3f, AssignCommand(oNPC, DetermineCombatRound(oPC, 1)));

            iCounter++;
        }
    }
}

