//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_swayabm1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Change ambient sound when player leaves inn
//       level.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
object oArea = GetObjectByTag("ElventreeSwayingBoughInn");

AmbientSoundChangeDay(oArea, AMBIENT_SOUND_HOUSE_INTERIOR_1);

AmbientSoundChangeNight(oArea, AMBIENT_SOUND_HOUSE_INTERIOR_1);
}
