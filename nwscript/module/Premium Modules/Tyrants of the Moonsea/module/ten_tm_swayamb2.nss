//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_swayabm2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Change ambient sound when player enters inn
//       level.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oArea = GetObjectByTag("ElventreeSwayingBoughInn");

AmbientSoundChangeDay(oArea, AMBIENT_SOUND_NOBLE_TAVERN_TALK);

AmbientSoundChangeNight(oArea, AMBIENT_SOUND_NOBLE_TAVERN_TALK);
}
