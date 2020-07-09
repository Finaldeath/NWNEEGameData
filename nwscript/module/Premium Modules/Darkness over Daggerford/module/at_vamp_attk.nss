#include "nw_i0_generic"
void main()
{
    //vampire attacks
    object oPC=GetPCSpeaker();
    object oVamp=GetObjectByTag("db_vampire");
    DelayCommand(0.2,ChangeToStandardFaction(oVamp,STANDARD_FACTION_HOSTILE));
    DelayCommand(0.5,AssignCommand(oVamp,DetermineCombatRound(oPC)));
}
