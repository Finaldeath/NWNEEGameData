/*
    DLA_MEL_PCDEATH.nss
    gaoneng erick            June 24, 2006

    OnDeath event for the pc. Not actually used.
*/

#include "dla_mel_inc2"

void main()
{
    object pc = GetLastPlayerDied();
    if (GetTag(GetArea(pc)) == "dla_mel_area")
    {
        AssignCommand(pc, ClearAllActions());
        dla_EndMeleeTournament(pc, FALSE);
        return;
    }

    ExecuteScript("nw_o0_death", OBJECT_SELF);
}


//::///////////////////////////////////////////////
//:: dla_mel_pcdeath
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
     This code should be integrated into main
     OnPlayerDeath event script.
     It executes a custom code if the tag of
     the area matches the tag from melee fight area.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Jan 11, 2006
//:://////////////////////////////////////////////
/*
#include "dla_mel_inc"

void main()
{
    object oPC = GetLastPlayerDied();
    if (GetTag(GetArea(oPC)) == "dla_mel_area")
    {
      AssignCommand(oPC, ClearAllActions());
      DLA_EndFight(oPC);
      return;
    }

    ExecuteScript("nw_o0_death", OBJECT_SELF);

}
