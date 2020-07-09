//::///////////////////////////////////////////////
//:: FileName od_ac_wildelves
//:: On death variable setting for killing Wild Elves
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/21/2005 2:50:30 PM
//:://////////////////////////////////////////////

// unblock the streams
void DoUnblockStreams(object oPC)
{
    // remove the placeables
    int nC = 1;
    object oBlock = GetNearestObjectByTag("ac_riverblock", oPC, nC);
    while(GetIsObjectValid(oBlock))
    {
        SetPlotFlag(oBlock, FALSE);
        DestroyObject(oBlock);
        nC++;
        oBlock = GetNearestObjectByTag("ac_riverblock", oPC, nC);
    }

    AssignCommand(oPC, PlaySound("as_na_watcliff"));
    SoundObjectPlay(GetObjectByTag("ac_snd_stream1"));
    SoundObjectPlay(GetObjectByTag("ac_snd_stream2"));
    SoundObjectPlay(GetObjectByTag("ac_snd_stream3"));
    SoundObjectPlay(GetObjectByTag("ac_snd_stream4"));
}

// unblock the streams
void UnblockStreams(object oPC)
{
    DelayCommand(3.0, FadeToBlack(oPC, FADE_SPEED_FAST));
    DelayCommand(4.0, DoUnblockStreams(oPC));
    DelayCommand(5.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
}

void main()
{
    object oPC = GetFirstPC();

    int nD = GetLocalInt(GetModule(), "ac_elf_deaths");
    nD++;
    SetLocalInt(GetModule(), "ac_elf_deaths", nD);
    if (nD >= 8)
    {
        if (GetLocalInt(oPC, "ac_wildelves_quest") > 0)
        {
            if (GetLocalInt(GetModule(), "nWildElfStreamsUnblocked") == 0)
            {
                SetLocalInt(GetModule(), "nWildElfStreamsUnblocked", 1);
                AssignCommand(oPC, ClearAllActions(TRUE));
                AssignCommand(oPC, SpeakString("Now I can unblock those streams."));
                AssignCommand(oPC, ActionDoCommand(UnblockStreams(oPC)));
            }
        }
    }

    // run the standard death script
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
