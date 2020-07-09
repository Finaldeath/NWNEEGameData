// none of julap's riddles are active

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    return(GetLocalInt(oArea, "nJulapRiddleNumber") == 0);
}
