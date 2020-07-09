void main()
{
    object oMaganus = GetNearestObjectByTag("StrongholdMaganus", GetPCSpeaker());
    AssignCommand(oMaganus, SetFacing(DIRECTION_NORTH));
}
