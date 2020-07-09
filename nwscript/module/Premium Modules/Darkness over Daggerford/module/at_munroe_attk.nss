#include "nw_i0_generic"
void main()
{
    //the munroes attack
    object oPC=GetPCSpeaker();
    object oJethro=GetObjectByTag("db_jethromunroe");
    object oMethro=GetObjectByTag("db_methromunroe");
    object oYage=GetObjectByTag("db_yagemunroe");
    object oSossi=GetObjectByTag("db_sossimunroe");
    object oFang=GetObjectByTag("db_fang");
    SetLocalInt(GetModule(),"render",2);
    DelayCommand(0.2,ChangeToStandardFaction(oJethro,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.2,ChangeToStandardFaction(oMethro,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.2,ChangeToStandardFaction(oYage,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.2,ChangeToStandardFaction(oSossi,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.2,ChangeToStandardFaction(oFang,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.5,AssignCommand(oJethro,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oMethro,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oYage,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oSossi,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oFang,DetermineCombatRound(oPC)));
}
