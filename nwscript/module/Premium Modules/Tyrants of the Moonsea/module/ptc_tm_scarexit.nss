//Transition click script from Scarred Lands to Iyrauroth's Domain

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_horse"

const string sLastDismountWarningTime = "nLastDismountWarningTime";

// returns the current game time in seconds
int GetCurrentTimestamp()
{
    int n = GetTimeSecond();
    n += GetTimeMinute() * 60;
    n += GetTimeHour() * 3600;
    return n;
}

// show the world map if the party is not mounted (no horses past this point)
// .. try to avoid annoying the player by showing the message too often
void ShowWorldMap(object oPC)
{
    if (HorsePartyIsMounted(oPC))
    {
        int nCurTime = GetCurrentTimestamp();
        int nLastWarningTime = GetLocalInt(oPC, sLastDismountWarningTime);
        if ((nCurTime - nLastWarningTime) > 5)
        {
            SetLocalInt(oPC, sLastDismountWarningTime, nCurTime);
            AssignCommand(oPC, ClearAllActions());
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 0.3f);
            DelayCommand(0.1f, AssignCommand(oPC, ClearAllActions()));
            DelayCommand(0.2f, AssignCommand(oPC, ActionStartConversation(oPC, "tm_horsenoway", FALSE, FALSE)));
        }
    }
    else
    {
        HorsePartyHitchHorses(oPC);
        ExecuteScript("hf_map_show", OBJECT_SELF);
        DeleteLocalInt(oPC, sLastDismountWarningTime);
    }
}

void main()
{
    int nClicked = GetLocalInt(OBJECT_SELF, "nClicked");

    object oClicker = GetClickingObject();
    object oDirector = GetObjectByTag("KTDirector");
    object oElf = GetNearestObjectByTag("Elf", GetFirstPC());
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if(GetIsPC(oClicker) && PlotLevelGet("Elf") == 14 &&
       GetIsObjectValid(oElf))
    {
        //Initiate Elf dialog after meeting Tusk, but don't block critical
        //path if dialog isn't initiating for some reason
        if(nClicked < 3)
        {
            nClicked++;
            SetLocalInt(OBJECT_SELF, "nClicked", nClicked);
            if(!IsInConversation(oElf) && !GetIsInCombat(oElf))
            {
                AssignCommand(oElf, ClearAllActions(TRUE));
                AssignCommand(oElf, ActionStartConversation(oClicker));
            }
        }
        //Remove Elf and ensure he will appear in Kur-Tharsu Main Gate area
        else
        {
             DeleteLocalObject(oDirector, "oElf");
             DestroyObject(oElf);
             PlotLevelSet("Elf", 15);
             ShowWorldMap(oClicker);
         }
    }
    else
    if (GetIsPC(oClicker) && !GetIsInCombat(oClicker))
    {
         ShowWorldMap(oClicker);
    }
}
