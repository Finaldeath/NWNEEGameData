#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_score"

int StartingConditional()
{
    // display statistics
    object oPC = GetPCSpeaker();
    string sIdentifier = GetPCIdentifier(oPC);
    object oDungeon = GetCurrentDungeon();

    string sString = "";
    int nCount;

    // total points
    nCount = GetLocalInt(oDungeon, "nStatisticsPoints_" + sIdentifier);
    sString += "Total Points: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // total deaths
    nCount = GetLocalInt(oDungeon, "nStatisticsDeaths_" + sIdentifier);
    sString += "Number of Deaths: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // creatures killed
    nCount = GetLocalInt(oDungeon, "nStatisticsCreaturesKilled_" + sIdentifier);
    sString += "Creatures Killed: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // levels gained
    nCount = GetLocalInt(oDungeon, "nStatisticsLevelsGained_" + sIdentifier);
    sString += "Levels Gained: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // puzzles solved
    nCount = GetLocalInt(oDungeon, "nStatisticsPuzzlesSolved_" + sIdentifier);
    sString += "Puzzles Solved: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // areas discovered
    nCount = GetLocalInt(oDungeon, "nStatisticsAreasDiscovered_" + sIdentifier);
    sString += "Areas Discovered: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // depth achieved
    nCount = GetLocalInt(oDungeon, "nStatisticsMaxDepth_" + sIdentifier);
    sString += "Maximum Depth Achieved: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // secrets discovered
    nCount = GetLocalInt(oDungeon, "nStatisticsSecretsDiscovered_" + sIdentifier);
    sString += "Secrets Discovered: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // locks picked
    nCount = GetLocalInt(oDungeon, "nStatisticsLockPicked_" + sIdentifier);
    sString += "Locks Picked: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // traps disarmed
    nCount = GetLocalInt(oDungeon, "nStatisticsTrapsDisarmed_" + sIdentifier);
    sString += "Traps Disarmed: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // plots completed
    nCount = GetLocalInt(oDungeon, "nStatisticsPlotsCompleted_" + sIdentifier);
    sString += "Plots Completed: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // bosses defeated
    nCount = GetLocalInt(oDungeon, "nStatisticsBossesDefeated_" + sIdentifier);
    sString += "Bosses Defeated: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    // minibosses defeated
    nCount = GetLocalInt(oDungeon, "nStatisticsMiniBossesDefeated_" + sIdentifier);
    sString += "Minibosses Defeated: " + IntToString(nCount);
    sString = AddLineBreak(sString);

    SetCustomToken(5100, sString);

    return TRUE;
}
