//::///////////////////////////////////////////////
//:: Name nat_potsc_common
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Physically Attacked script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "nw_i0_generic"
#include "inc_debtsystem"

void main()
{
    object oAttacker = GetLastAttacker();
    object oModule = GetModule();
    object oSelf = OBJECT_SELF;
    int iHostile = GetLocalInt(oSelf, "POTSC_COMMONER_HOSTILE");
    int iDebounce = GetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE");

    if (GetIsPossessedFamiliar(oAttacker) == TRUE)
    {
        oAttacker = GetMaster(oAttacker);
    }

    // If the Player has not started a full out combat charge them
    if (iHostile == FALSE)
    {
        // if the attacker was a player start up the debt system
        if ((GetIsPC(oAttacker) == TRUE) || (GetIsPC(GetMaster(oAttacker)) == TRUE))
        {
            if (iDebounce == FALSE)
            {
                SetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE", TRUE);
                AssignCommand(oModule, AddToDebtList
                    (oAttacker, oSelf, POTSC_ASSAULT));
                DelayCommand(10.0f, AssignCommand(oModule,
                    SetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE", FALSE)));
            }
        }

        // The commoners are allowed to fight if their not plot or immortal
        if ((GetPlotFlag(oSelf) == FALSE) && (GetImmortal(oSelf) == FALSE))
        {
            SetLocalInt(oSelf, "POTSC_COMMONER_HOSTILE", TRUE);
            ChangeToStandardFaction(oSelf, STANDARD_FACTION_HOSTILE);
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oAttacker);
            DetermineCombatRound(oAttacker);
        }
        else
        {
            SurrenderToEnemies();
            ClearPersonalReputation(oAttacker, oSelf);
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oAttacker);
        }
    }

    return;
}
