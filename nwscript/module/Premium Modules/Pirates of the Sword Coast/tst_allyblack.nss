void UnlockDoors();

void main()
{
    SetLocalInt(GetModule(), "A0_BLOODSAILOR_ALLY", FALSE);
    SetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY", TRUE);
    UnlockDoors();
}

void UnlockDoors()
{
    object oDoorB = GetObjectByTag("a0_drseige0");
    object oDoor1 = GetObjectByTag("a0_drseige1");
    object oDoor2 = GetObjectByTag("a0_drseige2");
    object oDoor3 = GetObjectByTag("a0_drseige3");
    object oDoor4 = GetObjectByTag("a0_drseige4");

    object oWPDoorB = GetObjectByTag("a0_wpseigeb");
    object oWPDoor1 = GetObjectByTag("a0_wpseigea1");
    object oWPDoor2 = GetObjectByTag("a0_wpseigea2");
    object oWPDoor3 = GetObjectByTag("a0_wpseigea3");
    object oWPDoor4 = GetObjectByTag("a0_wpseigea4");

    SetLocked(oDoorB, FALSE);
    SetLocked(oDoor1, FALSE);
    SetLocked(oDoor2, FALSE);
    SetLocked(oDoor3, FALSE);
    SetLocked(oDoor4, FALSE);

    SetMapPinEnabled(oWPDoorB, TRUE);
    SetMapPinEnabled(oWPDoor1, TRUE);
    SetMapPinEnabled(oWPDoor2, TRUE);
    SetMapPinEnabled(oWPDoor3, TRUE);
    SetMapPinEnabled(oWPDoor4, TRUE);
}
