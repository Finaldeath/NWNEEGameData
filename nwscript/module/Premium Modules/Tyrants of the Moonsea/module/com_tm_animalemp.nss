//Is the creature dominated by a PC?
int StartingConditional()
{
    return (GetMaster(OBJECT_SELF) == GetPCSpeaker());
}
