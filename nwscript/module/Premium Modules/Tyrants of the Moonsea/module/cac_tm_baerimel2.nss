//Baerimel faces PC
void main()
{
    object oBaerimel = GetNearestObjectByTag("Baerimel", GetPCSpeaker());

    AssignCommand(oBaerimel, SetFacing(DIRECTION_NORTH));
}
