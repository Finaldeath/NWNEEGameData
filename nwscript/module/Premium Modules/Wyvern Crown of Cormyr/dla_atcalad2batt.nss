//::///////////////////////////////////////////////
//:: dla_atcalad2btt
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
  Battlefield area, caladinei script
  Trigger the battle start
  To the sound of drums, the enemy army arrives in 3 waves.
*/
//:://////////////////////////////////////////////
//:: Created By: Ben W-Husey (B G P Hughes)
//:: Created On: January 2006
//:://////////////////////////////////////////////

#include "cu_functions"

//Gale: Storing oPC on the area, for easier retrieving.
//Removed setting variable on party that mark battle end.
//It's now set when the function on dla_i0_battle is called

// Ben W-Husey: Moved all the music calls into a seperate function.
// Why can't I fade volume smoothly or do it for battle track?!
void ArrivalSound(object oSound1,object oSound2,object oSound3) // Feed the sounds to be played
{
    float fDelay = 0.0;
    DelayCommand(fDelay+=6.0,SoundObjectPlay(oSound3));
    DelayCommand(fDelay+=1.0,SoundObjectPlay(oSound1));
    DelayCommand(fDelay+=5.0,SoundObjectPlay(oSound2));
    DelayCommand(fDelay+=4.0,SoundObjectPlay(oSound3));
}


void main()
{
    object oPC = GetPCSpeaker();
    SetLocalObject(GetArea(OBJECT_SELF), "oPC", oPC);
    object oSound = GetObjectByTag("SoundDrum1");
    object oSound2 = GetObjectByTag("SoundDrum2");
    object oSound3 = GetObjectByTag("SoundHorn");
    // "Fade" the sound
    DelayCommand(1.0,AmbientSoundSetDayVolume(GetArea(oPC),70));
    DelayCommand(2.0,AmbientSoundSetDayVolume(GetArea(oPC),40));
    DelayCommand(3.0,AmbientSoundSetDayVolume(GetArea(oPC),20));
    DelayCommand(4.0,AmbientSoundSetDayVolume(GetArea(oPC),0));
    DelayCommand(1.0,AmbientSoundSetNightVolume(GetArea(oPC),70));
    DelayCommand(2.0,AmbientSoundSetNightVolume(GetArea(oPC),40));
    DelayCommand(3.0,AmbientSoundSetNightVolume(GetArea(oPC),20));
    DelayCommand(4.0,AmbientSoundSetNightVolume(GetArea(oPC),0));
    DelayCommand(4.1,MusicBackgroundStop(GetArea(oPC)));
    //Handle each wave arrival, with sound
    DelayCommand(4.0,ArrivalSound(oSound,oSound2,oSound3));
    ///*****debug line********
//    DelayCommand(13.0,ExecuteScript("misc_batwave2",oPC)); // TEST LINE

    DelayCommand(13.0,ExecuteScript("misc_batwave1",oPC)); // Wave 1 (big and few - get the numbers down)
    DelayCommand(90.0,ArrivalSound(oSound,oSound2,oSound3));
    DelayCommand(100.0,ExecuteScript("misc_batwave2",oPC)); //Wave 2 + Witch Lord
    DelayCommand(140.0,ArrivalSound(oSound,oSound2,oSound3));
    DelayCommand(150.0,ExecuteScript("misc_batwave3",oPC)); // Wave 3 and Witch Lord teleports out
    // reset ambient sound volumes for after the battle
    DelayCommand(150.0,AmbientSoundSetDayVolume(GetArea(oPC),100));
    DelayCommand(150.0,AmbientSoundSetNightVolume(GetArea(oPC),100));
//    */
}
