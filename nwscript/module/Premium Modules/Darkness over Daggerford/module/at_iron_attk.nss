#include "nw_i0_generic"
void main()
{
    object oPC=GetPCSpeaker();
    int i = 1;
           object oArcher = GetNearestObjectByTag("db_itarcher",oPC,i);
           while(oArcher != OBJECT_INVALID)
                 {
                 ChangeToStandardFaction(oArcher,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.2,AssignCommand(oArcher,DetermineCombatRound(oPC)));
                 i++;
                 oArcher = GetNearestObjectByTag("db_itarcher",oPC,i);
                 }
           i = 1;
           object oWarrior = GetNearestObjectByTag("db_itwarrior",oPC,i);
           while(oWarrior != OBJECT_INVALID)
                 {
                 ChangeToStandardFaction(oWarrior,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.2,AssignCommand(oWarrior,DetermineCombatRound(oPC)));
                 i++;
                 oWarrior = GetNearestObjectByTag("db_itwarrior",oPC,i);
                 }
           i = 1;
           object oWarrior2 = GetNearestObjectByTag("db_itwarrior2",oPC,i);
           while(oWarrior2 != OBJECT_INVALID)
                 {
                 ChangeToStandardFaction(oWarrior2,STANDARD_FACTION_HOSTILE);
                 DelayCommand(0.2,AssignCommand(oWarrior2,DetermineCombatRound(oPC)));
                 i++;
                 oWarrior2 = GetNearestObjectByTag("db_itwarrior2",oPC,i);
                 }
}
