// PC is in a Thunderstone area

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    if ((GetStringLeft(GetTag(oArea),5)== "Thund") || (GetStringLeft(GetTag(oArea),5)== "Hawkl")) return TRUE;
    return FALSE;

}
