//The Bron turns to face the PC
void main()
{
    object oBron = GetNearestObjectByTag("TheBron");
    AssignCommand(oBron, SetFacingPoint(GetPosition(GetFirstPC())));
}
