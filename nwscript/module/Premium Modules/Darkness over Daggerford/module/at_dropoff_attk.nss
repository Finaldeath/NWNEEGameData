#include "nw_i0_generic"
#include "hf_in_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oMrFaction=GetNearestObjectByTag("db_factiondude");
    object oHerab = GetObjectByTag("db_shipscaptain");
    object oTanarukkLeader = GetObjectByTag("db_tanarukklead1");
    object oHound = GetObjectByTag("db_hound");
    object oTanarukk = GetObjectByTag("db_tanarukk_do");
    ChangeFaction(oHerab, oMrFaction);
    ChangeFaction(oTanarukkLeader, oMrFaction);
    ChangeFaction(oHound, oMrFaction);
    ChangeFaction(oTanarukk, oMrFaction);
    DelayCommand(0.5,AssignCommand(oHerab,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oTanarukkLeader,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oHound,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oTanarukk,DetermineCombatRound(oPC)));
    CutsceneNextShot();
}
