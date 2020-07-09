//::///////////////////////////////////////////////
//:: dla_d1_jousttrum
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Play a sound - make sure the tag of the sound object is 'Playsound'
    (and it's the nearest to the trigger with that name)

    Syrsnein, 1 Mar 2006:
        Changed to use animated trumpeters and change the tag of the object
        sound to use a specific sound object since we have two fanfare sound
        objects now.  This script is called from a dialogue.
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: January, 2005
//:://////////////////////////////////////////////

void dla_trumpet_play(object oTrumpetter, object oFanfare)
{
    AssignCommand(oTrumpetter, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM3, 1.0, 5.0));
    SoundObjectSetVolume(oFanfare, 127);
    DelayCommand(1.0, SoundObjectPlay(oFanfare));
    DelayCommand(15.0,SoundObjectStop(oFanfare));
}

void main()
{
    int n=0;
    object oTrumpetter = GetObjectByTag("dla_joust_trumpetter", n);
    object oFanfare = GetObjectByTag("dla_joust_fanfare2", n);
    while (GetIsObjectValid(oTrumpetter))
    {
        // clear actions
        AssignCommand(oTrumpetter, ClearAllActions());
        // blow trumpet
        dla_trumpet_play(oTrumpetter, oFanfare);
        // Get the next trumpeter
        n++;
        oTrumpetter = GetObjectByTag("dla_joust_trumpetter", n);
//        oFanfare = GetObjectByTag("dla_joust_fanfare2", n);
    }
}
