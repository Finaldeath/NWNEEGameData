// B W-Husey
// Macrh 2006
// Sums up the alignment score of the PC, and displays it as a percentage of the total possible.

void main()
{
    object oPC = GetPCSpeaker();
    int MyScore = GetLocalInt(oPC,"MyScore");
    int TotScore = GetLocalInt(oPC,"AllScore");
    float Tot = IntToFloat(TotScore);
    float My = IntToFloat(MyScore);
    float fPercent = (My/Tot)*100;
    int nPercent = FloatToInt(fPercent);
    SetCustomToken(1060,IntToString(TotScore));
    SetCustomToken(1055,IntToString(nPercent));
}
