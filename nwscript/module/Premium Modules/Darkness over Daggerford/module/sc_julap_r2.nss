// julap's second riddle is active

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    return(GetLocalInt(oArea, "nJulapRiddleNumber") == 2);
}
