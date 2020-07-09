//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: pfp_tm_meetdoor
// DATE: August 26, 2005
// AUTH: Luke Scull
// NOTE: Stop PC entering inn until after Madoc conv.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    if (GetLocalInt(GetFirstPC(), "NW_JOURNAL_ENTRYVoonlar") < 10)
    {
        SpeakString("You'd better help Madoc first or you won't get paid.");
        object oTarget;
        oTarget = GetObjectByTag("MadoctheUncouth");
        DelayCommand(2.5, AssignCommand (oTarget, SpeakString("Don't you be thinking about slinking off to the inn until these crates are taken care of!", TALKVOLUME_SHOUT)));
    }
    else
    if (GetLocalInt(GetFirstPC(), "NW_JOURNAL_ENTRYVoonlar") == 20)
    {
        ActionSpeakString("You cannot flee the area while the Bron is attacking!");
    }
    else
    {
        ActionSpeakString("The door had been hastily locked. You can hear the sounds of large objects, likely furniture, being shoved up against it.");
    }
}
