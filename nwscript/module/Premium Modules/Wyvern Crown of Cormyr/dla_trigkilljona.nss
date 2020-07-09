// March 2006
// B W-Husey
// Extra insurance to make sure Jonas disappears.

void main()
{
    object oJonas = GetEnteringObject();

    if (GetTag(oJonas)=="Jonas" && GetLocalInt(oJonas,"nManthiaPlot1")==4)
    {
    SetPlotFlag(oJonas,FALSE);
    SetImmortal(oJonas,FALSE);
    AssignCommand(oJonas,SetIsDestroyable(TRUE));
    DestroyObject(oJonas,0.5);
    }
}
