void main()
{
    object oStone = GetObjectByTag("am_ar2000_rune1");
    SetPlotFlag(oStone, FALSE);
    DestroyObject(oStone);
    oStone = GetObjectByTag("am_ar2000_rune2");
    SetPlotFlag(oStone, FALSE);
    DestroyObject(oStone);
    oStone = GetObjectByTag("am_ar2000_rune3");
    SetPlotFlag(oStone, FALSE);
    DestroyObject(oStone);
}
