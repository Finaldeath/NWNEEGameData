//The Bron turns to face Madoc
void main()
{
    object oBron = GetNearestObjectByTag("TheBron");
    object oMadoc = OBJECT_SELF;
    AssignCommand(oBron, SetFacingPoint(GetPosition(oMadoc)));
}
