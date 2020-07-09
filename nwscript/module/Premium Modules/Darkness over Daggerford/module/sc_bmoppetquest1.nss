int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();

    iResult = (GetLocalInt(oPC, "nBoonMoppetQuest") == 1); // accepted quest
    return iResult;
}
