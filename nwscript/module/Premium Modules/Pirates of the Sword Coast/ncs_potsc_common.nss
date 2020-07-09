//::///////////////////////////////////////////////
//:: Name ncs_potsc_common
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spell Cast at script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "nw_i0_generic"
#include "inc_debtsystem"

void main()
{
    object oCaster = GetLastSpellCaster();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHarmful = GetLastSpellHarmful();
    int iHostile = GetLocalInt(oSelf, "POTSC_COMMONER_HOSTILE");
    int iDebounce = GetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE");

    if (GetIsPossessedFamiliar(oCaster) == TRUE)
    {
        oCaster = GetMaster(oCaster);
    }

    // if the spell is hostile start the system
    if ((iHarmful == TRUE) && (iHostile == FALSE))
    {
        // if the attacker was a player start up the debt system
        if ((GetIsPC(oCaster) == TRUE) || (GetIsPC(GetMaster(oCaster)) == TRUE))
        {
            if (iDebounce == FALSE)
            {
                SetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE", TRUE);

                AssignCommand(oModule, AddToDebtList
                    (oCaster, oSelf, POTSC_ASSAULT));
                DelayCommand(10.0f, AssignCommand(oModule,
                    SetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE", FALSE)));
            }
        }

        // The commoners are allowed to fight if their not plot or immortal
        if ((GetPlotFlag(oSelf) == FALSE) && (GetImmortal(oSelf) == FALSE))
        {
            SetLocalInt(oSelf, "POTSC_COMMONER_HOSTILE", TRUE);
            ChangeToStandardFaction(oSelf, STANDARD_FACTION_HOSTILE);
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oCaster);
            DetermineCombatRound(oCaster);
        }
        else
        {
            SurrenderToEnemies();
            ClearPersonalReputation(oCaster, oSelf);
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oCaster);
        }
    }

    return;
}
