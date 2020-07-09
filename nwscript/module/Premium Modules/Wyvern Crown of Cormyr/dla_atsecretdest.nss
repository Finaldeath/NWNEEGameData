void main()
{
   DestroyObject(GetObjectByTag("PFUSecretBoulder"));
    object oSound = GetNearestObjectByTag("Playsound");
    SoundObjectPlay(oSound);
}
