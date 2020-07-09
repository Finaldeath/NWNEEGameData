//::///////////////////////////////////////////////
//:: exe_a1garmsurr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Garm has been defeated in the arena. He
    surrenders and you are jumped to the official
    troglodyte village.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"

void RemoveInvis (object oPC);

// Jump to the trog village
void main()
{
    object oModule = GetModule();
    object oArea1 = GetObjectByTag("a1_trogarena");
    object oArea2 = GetObjectByTag("a1_trogcutcapture");
    object oFighter = GetLocalObject(oArea1, "A1_CURRFIGHTER");

    object oJumpGarm = GetWaypointByTag("a1_garmpos");
    object oJumpFighter = GetWaypointByTag("a1_escfighter");
    object oJumpWatcher = GetWaypointByTag("a1_villcell");
    object oPC = GetFirstObjectInArea(oArea1);
    object oGarm;

    int iToggle, iLevel, iHitDice;

    oGarm = GetObjectByTag("a1_hench_garm");
    iHitDice = GetFactionAverageLevel(oFighter);
    iLevel = GetHitDice(oGarm);

    iToggle = GetLocalInt(oGarm, "POTSC_HENCH_TOGGLE");
    while (iLevel < iHitDice)
    {
        if (iToggle == FALSE)
        {
            iLevel = LevelUpHenchman(oGarm, CLASS_TYPE_CLERIC, TRUE, PACKAGE_CLERIC_SHAMAN);
            iToggle = TRUE;
        }
        else
        {
            iLevel = LevelUpHenchman(oGarm, CLASS_TYPE_FIGHTER, TRUE, PACKAGE_FIGHTER_GLADIATOR);
            iToggle = FALSE;
        }
    }

    SetLocalInt(oGarm, "POTSC_HENCH_TOGGLE", iToggle);
    HireHenchman(oFighter, oGarm);
    SetImmortal(oGarm, FALSE);

    while (GetIsObjectValid(oPC) == TRUE)
    {
        FadeToBlack(oPC);
        DelayCommand(2.0f, SetCutsceneMode(oPC, FALSE));
        DelayCommand(2.0f, RemoveInvis(oPC));
        DelayCommand(2.5f, FadeFromBlack(oPC));

        if (oFighter == oPC)
        {
            DelayCommand(2.1f, AssignCommand(oPC, JumpToObject(oJumpFighter)));
        }
        else if (GetIsPC(oPC) == TRUE)
        {
            SetLocalInt(oPC, "A1_WATCHING_FIGHT", FALSE);
            DelayCommand(2.1f, AssignCommand(oPC, JumpToObject(oJumpWatcher)));
        }

        SetImmortal(oPC, FALSE);
        oPC = GetNextObjectInArea(oArea1);
    }

    oPC = GetFirstObjectInArea(oArea2);
    while (GetIsObjectValid(oPC) == TRUE)
    {
        FadeToBlack(oPC);
        DelayCommand(2.0f, SetCutsceneMode(oPC, FALSE));
        DelayCommand(2.0f, RemoveInvis(oPC));
        DelayCommand(2.5f, FadeFromBlack(oPC));

        if (oFighter == oPC)
        {
            DelayCommand(2.1f, AssignCommand(oPC, JumpToObject(oJumpFighter)));
        }
        else if (GetIsPC(oPC) == TRUE)
        {
            DelayCommand(2.1f, AssignCommand(oPC, JumpToObject(oJumpWatcher)));
        }

        oPC = GetNextObjectInArea(oArea2);
    }
}

// remove cutscene invisibility
void RemoveInvis (object oPC)
{
    effect eEffect = GetFirstEffect(oPC);

    while (GetIsEffectValid(eEffect) == TRUE)
    {
        if(GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
        {
            DelayCommand(0.1f, RemoveEffect(oPC, eEffect));
        }

        eEffect = GetNextEffect(oPC);
    }
}
