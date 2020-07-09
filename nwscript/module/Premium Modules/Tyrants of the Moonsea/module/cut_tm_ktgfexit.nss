//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_ktgfexit
// DATE: December 11, 2018
// AUTH: Rich Barker
// NOTE: Cutscene and dialogue for Blizzard/Elf departure in Kur-Tharsu
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_TAG_BLIZZARD = "Blizzard";
const string WP_TAG_BLIZZARD_INIT = "WP_THKTGF_CS_BLIZZARD_JUMP";

const string NPC_TAG_ELF = "Elf";
const string WP_TAG_ELF_INIT = "WP_THKTGF_CS_ELF_JUMP";

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_BLIZZARD, oPC);
    if(GetIsObjectValid(oActor))
    {
        CutsceneAddActor(NPC_TAG_BLIZZARD, oActor);
        PlotLevelSet(NPC_TAG_BLIZZARD, 17);
        AssignCommand(oActor, ClearAllActions(TRUE));
        AssignCommand(oActor,
            JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_BLIZZARD_INIT))));
    }

    oActor = GetNearestObjectByTag(NPC_TAG_ELF, oPC);

    if(GetIsObjectValid(oActor))
    {
        CutsceneAddActor(NPC_TAG_ELF, oActor);
        PlotLevelSet(NPC_TAG_ELF, 21);
        AssignCommand(oActor, ClearAllActions(TRUE));
        AssignCommand(oActor,
            JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_ELF_INIT))));
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, ClearAllActions());
    CutsceneStart(FALSE, FALSE, "WP_THKTGF_CS_PC_START", FALSE);
    BlackScreen(oPC);
    SetupActors(oPC);
}

// Blizzard talks to player if present
void next0(float fTime)
{
    object oBlizzard = CutsceneGetActor(NPC_TAG_BLIZZARD);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        if(GetIsObjectValid(oBlizzard))
        {
            CutsceneNext(3.0);
        }
        else
        {
            CutsceneNextShot();
        }
    }
    else if (fTime == 3.0)
    {
        StopFade(oPC);
        //CutsceneNextShot() invoked from Blizzard conversation
        AssignCommand(oBlizzard, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// Elf talks to player if present
void next1(float fTime)
{
    object oElf = CutsceneGetActor(NPC_TAG_ELF);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        if(GetIsObjectValid(oElf))
        {
            CutsceneNext(3.0);
        }
        else
        {
            CutsceneNextShot();
        }
    }
    else if (fTime == 3.0)
    {
        StopFade(oPC);
        //CutsceneNextShot() invoked from Elf conversation
        AssignCommand(oElf, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next2(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

void abort()
{

}

void end()
{
    object oBlizzard = CutsceneGetActor(NPC_TAG_BLIZZARD);
    object oElf = CutsceneGetActor(NPC_TAG_ELF);
    object oPC = CutsceneGetPC();

    //Ensure correct values set on Elf/Blizzard in case cutscene was aborted
    PlotLevelSet(NPC_TAG_BLIZZARD, 17);
    PlotLevelSet(NPC_TAG_ELF, 21);

    //Remove Blizzard and Elf as appropriate
    if(GetIsObjectValid(oBlizzard))
    {
        SetLocalString(oBlizzard, "HF_EXIT_NAME", "WP_THKTGF_CS_BLIZZARD_EXIT");
        DelayCommand(2.5, ExecuteScript("hf_cs_exit", oBlizzard));
    }

    if(GetIsObjectValid(oElf))
    {
        SetLocalString(oElf, "HF_EXIT_NAME", "WP_THKTGF_CS_ELF_EXIT");
        DelayCommand(2.5, ExecuteScript("hf_cs_exit", oElf));
    }
}

void main()
{
    int nShot = CutsceneGetShot();
    float fTime = CutsceneGetTime();
    int nEvent = CutsceneGetEvent();

    if (nEvent == CUTSCENE_EVENT_START)
    {
        start();
        CutsceneNext(0.0);
    }
    else if (nEvent == CUTSCENE_EVENT_SHOT ||
             nEvent == CUTSCENE_EVENT_NEXT)
    {
        if (nShot == 0) next0(fTime);
        if (nShot == 1) next1(fTime);
        if (nShot == 2) next2(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
