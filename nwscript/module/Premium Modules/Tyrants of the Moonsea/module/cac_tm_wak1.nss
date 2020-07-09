//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_wak1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: See below for detailed commenting.
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

object oWaypoint2 = GetObjectByTag("WP_TemplePlumes_Flee");

object oKaine = GetObjectByTag("Kaine");

object oMattius = GetObjectByTag("Mattius");

object oWak = GetObjectByTag("WakRatharSimulacrum");

object oArea = GetObjectByTag("HillsfarInnerCity");

// Wak casts fake spell and teleports away

cs_ActionCastFakeSpellAtObject(0.0, oWak, VFX_FNF_SUMMON_MONSTER_1, oWak, PROJECTILE_PATH_TYPE_DEFAULT, oArea, 1);

cs_ApplyVFXToObject(1.0, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_MONSTER_1, oWak, 0.0, FALSE, TRUE, oArea, 1);

cs_JumpToObject(1.0, oWak, oWaypoint, oArea, 1);

// Red Plumes walk away and are destroyed

cs_ActionMoveToObject(0.5, oKaine, oWaypoint2, FALSE, 1.0, oArea, 1);

cs_ActionMoveToObject(0.0, oMattius, oWaypoint2, FALSE, 1.0, oArea, 1);

cs_CameraDoFade(1.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM, oArea, 1);

cs_DestroyObject(0.5, oKaine, oArea, 1);

cs_DestroyObject(0.0, oMattius, oArea, 1);

// End cutscene

cs_EndCutscene(3.0, TRUE, FALSE, FADE_SPEED_MEDIUM, 1, oArea);

// Add Madmen and Villains journal entry

DelayCommand(12.0, AddJournalQuestEntry("CrazedOldMan", 32, oPC));
}
*/
