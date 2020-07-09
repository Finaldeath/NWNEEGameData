int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return (GetMaster(OBJECT_SELF) == oPC);
}
