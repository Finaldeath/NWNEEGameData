//::///////////////////////////////////////////////
//:: FileName ou_ac_daxlever
//:: Toggle the lever; if on, open door
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 2/8/2006 3:25:02 PM
//:://////////////////////////////////////////////

void main()
{
    object oD = GetObjectByTag("dr_ac_daxiong");
    object oPC = GetLastUsedBy();

    int nUsed1 = GetLocalInt(OBJECT_SELF, "LEVER_STATE");
    if (nUsed1 == 1)
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetLocalInt(OBJECT_SELF, "LEVER_STATE", 0);
        SoundObjectPlay(GetObjectByTag("ac_snd_daxdoor2"));
        DelayCommand(1.5, SoundObjectStop(GetObjectByTag("ac_snd_daxdoor2")));
        SetLocked(oD, TRUE);
        AssignCommand(oD, ActionCloseDoor(oD));
        AssignCommand(oPC, SpeakString("From far away, you hear the sound of a door closing."));
    }
    else
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(OBJECT_SELF, "LEVER_STATE", 1);
        SoundObjectPlay(GetObjectByTag("ac_snd_daxdoor"));
        DelayCommand(1.5, SoundObjectStop(GetObjectByTag("ac_snd_daxdoor")));
        SetLocked(oD, FALSE);
        AssignCommand(oD, ActionOpenDoor(oD));
        AssignCommand(oPC, SpeakString("From far away, you hear the sound of a door opening."));
    }
}

