// Jan 2005
// B W-Husey
// Play a sound - make sure the tag of the sound object is 'Playsound' (and it's the nearest
// to the trigger with that name)

void main()
{
    if (GetLocalInt(OBJECT_SELF,"nOnce")<1)
    {
    object oSound = GetNearestObjectByTag("Playsound");
    SoundObjectPlay(oSound); //play the sound
    DelayCommand(10.0,SoundObjectStop(oSound));//stop the sound
    SetLocalInt(OBJECT_SELF,"nOnce",1);
    DestroyObject(OBJECT_SELF,11.0); //We don't want the sound to keep triggering
    }
}

