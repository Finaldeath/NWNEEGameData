//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_garth6
//:: DATE: March 17, 2006.
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar Arena cutscene
//::////////////////////////////////////////////////////
//:: Player chooses buff, Garth and Elf both die
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oGarth = OBJECT_SELF;
    object oElf = GetObjectInArea("Elf", oGarth);


    AddJournalQuestEntry("HillsfarArenaFatherGarth", 30, oPC);
    PlotLevelSet("Elf-Arena-Outcome", 1); // Elf is sacrificed

    SetPlotFlag(oGarth, FALSE);
    SetImmortal(oGarth, FALSE);
    DelayCommand(0.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oGarth));

    SetPlotFlag(oElf, FALSE);
    SetImmortal(oElf, FALSE);
    DelayCommand(0.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oElf));

    CutsceneNextShot();
}
