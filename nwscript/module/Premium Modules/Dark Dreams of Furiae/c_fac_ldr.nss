int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oLeader = GetFactionLeader(oPC);
    iResult = oPC == oLeader;
    return iResult;
}
