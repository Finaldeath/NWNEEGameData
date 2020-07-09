// TODO:DELETE
// Moved to cut_tm_zalazar

void main()
{

object oPC = GetPCSpeaker();

object oVoice = GetObjectByTag("ZalazarVoice");

DestroyObject(oVoice, 0.0);

AddJournalQuestEntry( "TheElvenHamlet", 60, oPC);

SetLocalInt(oPC, "elventreeattacked", 2);

MusicBattlePlay(GetObjectByTag("Elventree"));

SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup1"));

SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup2"));

SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup3"));

SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup4"));

SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup5"));

DoSinglePlayerAutoSave();

}
