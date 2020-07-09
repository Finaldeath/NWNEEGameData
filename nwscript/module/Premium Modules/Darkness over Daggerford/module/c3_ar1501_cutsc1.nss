// this script is triggered when the player opens one of the doors to the
// .. goblin butcher's area. It just disables the goblin's ambient AI
// .. and starts a cutscene

#include "hf_in_cutscene"

object GetNearestCreatureByTag(string sTag, object oPC, int n=1)
{
    int i = n;
    object oNPC = OBJECT_INVALID;
    oNPC = GetNearestObjectByTag(sTag, oPC, i);
    while (GetIsObjectValid(oNPC))
    {
        if (GetObjectType(oNPC) == OBJECT_TYPE_CREATURE)
        {
            break;
        }
        oNPC = GetNearestObjectByTag(sTag, oPC, ++i);
    }
    return(oNPC);
}

void GoblinsBusy(object oPC)
{
    int i = 1;
    object oGoblin = GetNearestCreatureByTag("db_flee_goblin", oPC, i);
    while (GetIsObjectValid(oGoblin))
    {
        float fDist = GetDistanceBetween(oPC, oGoblin);
        if (fDist >= 0.0 && fDist <= 40.0)
        {
            SignalEvent(oGoblin, EventUserDefined(998));
        }
        oGoblin = GetNearestCreatureByTag("db_flee_goblin", oPC, ++i);
    }
}

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC))
    {
        object oArea = GetArea(oPC);
        if (GetLocalInt(oArea, "nCutscene1Played") == 0)
        {
            SetLocalString(oArea, "sCutsceneEndWP", GetLocalString(OBJECT_SELF, "sCutsceneEndWP"));
            SetLocalInt(oArea, "nCutscene1Played", 1);
            GoblinsBusy(oPC);
            FadeToBlack(oPC, FADE_SPEED_SLOW);
            DelayCommand(2.0, CutscenePlay(oPC, "mv_ar1501_1"));
        }
    }
}
