// Jan 2005
// B W-Husey
// Play a sound - make sure the tag of the sound object is 'Playsound' (and it's the nearest
// to the trigger with that name)

// Specific one for Thunderstone: Forest Edge, since the sound there misbehaves and keeps firing on area enter for some unknown reason

void main()
{
if (GetLocalInt(OBJECT_SELF,"nFired")<1)
{
object oSound = GetNearestObjectByTag("Playsound");
SoundObjectPlay(oSound);
DelayCommand(15.0,SoundObjectStop(oSound));
DestroyObject(OBJECT_SELF, 15.1);
SetLocalInt(OBJECT_SELF,"nFired",1);
}
}

