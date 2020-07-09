//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_wak2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: See notes below for details.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

//Moved to cut_tm_waktemple
//TODO:DELETE
void main()
{
}
/*
void main()
{

// Define all objects in script

object oPC = GetFirstPC();

object oWaypoint = GetObjectByTag("WP_WakSimulacrum_Jump");

object oKaine = GetObjectByTag("Kaine");

object oMattius = GetObjectByTag("Mattius");

object oWak = GetObjectByTag("WakRatharSimulacrum");

object oArea = GetObjectByTag("HillsfarInnerCity");

// Wak casts a fake spell and teleports away

cs_ActionCastFakeSpellAtObject(0.0, oWak, VFX_FNF_SUMMON_MONSTER_1, oWak, PROJECTILE_PATH_TYPE_DEFAULT, oArea, 1);

cs_ApplyVFXToObject(1.0, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_1, oWak, 0.0, FALSE, TRUE, oArea, 1);

cs_JumpToObject(1.0, oWak, oWaypoint, oArea, 1);

// End cutscene

cs_EndCutscene(1.0, TRUE, FALSE, FADE_SPEED_MEDIUM, 1, oArea);

// Make Kaine and Mattius hostile

DelayCommand(9.0, AssignCommand(oKaine, SetIsTemporaryEnemy(oPC)));

DelayCommand(9.0, AssignCommand(oKaine, DetermineCombatRound()));

DelayCommand(9.0, AssignCommand(oKaine, ActionAttack(oPC)));

DelayCommand(9.0, AssignCommand(oMattius, SetIsTemporaryEnemy(oPC)));

DelayCommand(9.0, AssignCommand(oMattius, DetermineCombatRound()));

DelayCommand(9.0, AssignCommand(oMattius, ActionAttack(oPC)));

// Add Madmen and Villains journal entry

DelayCommand(9.0, AddJournalQuestEntry("CrazedOldMan", 31, oPC));
}
*/
