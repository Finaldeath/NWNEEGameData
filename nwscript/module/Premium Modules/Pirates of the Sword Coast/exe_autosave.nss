//::///////////////////////////////////////////////
//:: exe_autosave
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Protection script for the autosave feature.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iDebounce = GetLocalInt(oModule, "exe_autosave");

    if (iDebounce == FALSE)
    {
        SetLocalInt(oModule, "exe_autosave", TRUE);
        DelayCommand(0.01f, DoSinglePlayerAutoSave());
        DelayCommand(15.0f, SetLocalInt(oModule, "exe_autosave", FALSE));
    }
}
