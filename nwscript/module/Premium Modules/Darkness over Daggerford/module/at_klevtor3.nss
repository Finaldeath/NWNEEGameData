// make rugmax face the player during klevtor's dialog

void main()
{
    object oPC = GetPCSpeaker();
    object oRugmax = GetNearestObjectByTag("pm_rugmax", oPC);
    AssignCommand(oRugmax, SetFacingPoint(GetPosition(oPC)));
}
