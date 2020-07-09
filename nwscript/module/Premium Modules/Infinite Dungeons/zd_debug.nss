void main()
{
    PrintString("");

    // bCataloging
    int nNum = GetLocalInt(GetModule(), "bCataloging");
    PrintString("bCataloging is " + IntToString(nNum));

    // bDebugMode
    nNum = GetLocalInt(GetModule(), "bDebugMode");
    PrintString("bCataloging is " + IntToString(nNum));

    // bDebugModeP
    nNum = GetLocalInt(GetModule(), "bDebugModeP");
    PrintString("bCataloging is " + IntToString(nNum));

    // bDebugModeT
    nNum = GetLocalInt(GetModule(), "bDebugModeT");
    PrintString("bCataloging is " + IntToString(nNum));

    // bGenerating
    nNum = GetLocalInt(GetModule(), "bGenerating");
    PrintString("bCataloging is " + IntToString(nNum));

    // bMiniPlot
    nNum = GetLocalInt(GetModule(), "bMiniPlot");
    PrintString("bCataloging is " + IntToString(nNum));

    // bPlotDungeon
    nNum = GetLocalInt(GetModule(), "bPlotDungeon");
    PrintString("bCataloging is " + IntToString(nNum));

    PrintString("");
}
