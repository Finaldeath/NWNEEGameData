//Baerimel gets up from the floor and can be conversed with
void main()
{
    object oBaerimel = GetNearestObjectByTag("Baerimel", GetPCSpeaker());

    AssignCommand(oBaerimel, ClearAllActions());
    SetLocalInt(oBaerimel, "nBusy", 0);
}
