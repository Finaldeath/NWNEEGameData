//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_arena
//:: DATE: February 25, 2018
//:: AUTH: Attila Gyoerkoes
//:: NOTE: Start Hillsfar arena cutscenes
//::////////////////////////////////////////////////////
//:: Get the exact cutscene from quest variables
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"


// Get the name of the cutscene script to fire
string getArenaCutscene(object oPC)
{
    string sCutsceneScript = "";
    int nQuestVarHillsfarpass = GetLocalInt(oPC, "hillsfarpass");
    int nQuestVarInnovator = GetLocalInt(oPC, "innovator");

    if (nQuestVarHillsfarpass == 1)
    {
        sCutsceneScript = "cut_tm_arena5";  // last sequence, onehand fight
    }
    else
    {
        switch (nQuestVarInnovator)
        {
            case 6: sCutsceneScript = "cut_tm_arena4"; break;
            case 4: sCutsceneScript = "cut_tm_arena3"; break;
            case 3: sCutsceneScript = "cut_tm_arena2"; break;
            default: sCutsceneScript = "cut_tm_arena1";
        }
    }
    return sCutsceneScript;
}


void main()
{
    object oPC = GetEnteringObject();
    object oTrigger = OBJECT_SELF;

    if (GetIsPC(oPC))
    {
        // Fire cutscene script
        string sCutsceneScript = getArenaCutscene(oPC);
        if (sCutsceneScript != "")
        {
            // Don't fire the same cutscene twice
            if (GetLocalInt(oTrigger, sCutsceneScript) == 0)
            {
                SetLocalInt(oTrigger, sCutsceneScript, 1);

                MusicBattleStop(GetArea(OBJECT_SELF));
                MusicBackgroundStop(GetArea(OBJECT_SELF));
                CutscenePlay(oPC, sCutsceneScript);
            }
        }
        else
        {
            SendMessageToPC(oPC, "Error: Undefined arena cutscene.");
        }
    }
}
