//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_bane1
// DATE: October 30, 2005
// AUTH: Luke Scull
// NOTE: Destroy Manifestation of Bane, update journal.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetPCSpeaker();

object oTarget = GetObjectByTag("ManifestationofBane");

ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget);

AddJournalQuestEntry("EvilBeneathVoonlar", 50, oPC);

SetLocalInt(OBJECT_SELF, "nBusy", TRUE);
DestroyObject(oTarget, 3.0);

}

