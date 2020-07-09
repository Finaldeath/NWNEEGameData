#include "nw_i0_generic"
void main()
{
    object oPC = GetEnteringObject();
    object oDrelia = GetObjectByTag("db_drelia");
    object oBrenda = GetObjectByTag("db_brenda");
    object oMeyhew = GetObjectByTag("db_meyhew");
    //this integer flags that the harpers have gone hostile
    //it is used to trigger the area exit check to see if they are still alive
    SetLocalInt(GetModule(), "harpers_attacked", 1);
    DelayCommand(0.2,ChangeToStandardFaction(oDrelia,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.2,ChangeToStandardFaction(oBrenda,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.2,ChangeToStandardFaction(oMeyhew,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.5,AssignCommand(oDrelia,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oBrenda,DetermineCombatRound(oPC)));
    DelayCommand(0.5,AssignCommand(oMeyhew,DetermineCombatRound(oPC)));
}
