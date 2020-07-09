//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_garth7
//:: DATE: March 17, 2006.
//:: AUTH: Luke Scull
//:: NOTE: Hillsfar Arena cutscene
//::////////////////////////////////////////////////////
//:: Player chooses to heal elf, only Garth dies
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oGarth = OBJECT_SELF;
    object oElf = GetObjectInArea("Elf", OBJECT_SELF);


    AddJournalQuestEntry("HillsfarArenaFatherGarth", 40, oPC);
    PlotLevelSet("Elf-Arena-Outcome", 0); // survives

    SetPlotFlag(oGarth, FALSE);
    SetImmortal(oGarth, FALSE);
    DelayCommand(0.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oGarth));

    SetPlotFlag(oElf, FALSE);
    SetImmortal(oElf, FALSE);
    // Elf stays alive, but killable during combat

    CutsceneNextShot();
}

