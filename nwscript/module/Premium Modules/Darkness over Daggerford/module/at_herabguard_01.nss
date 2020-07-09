// the griffon guards in the barracuda leave

void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, oPC);

    GiveXPToCreature(oPC, 200);
    FloatingTextStringOnCreature("Griffon Guards convinced to leave peacefully - 200XP!", oPC);

    object oGuard1 = GetNearestObjectByTag("ks_griffon_guard", oPC, 1);
    SetLocalInt(oGuard1, "HF_EXIT_STARTED", 1);
    AssignCommand(oGuard1, ActionMoveToObject(oDoor));
    DestroyObject(oGuard1, 1.0);

    object oGuard2 = GetNearestObjectByTag("ks_griffon_guard", oPC, 2);
    SetLocalInt(oGuard2, "HF_EXIT_STARTED", 1);
    AssignCommand(oGuard2, SetFacingPoint(GetPosition(oDoor)));
    DestroyObject(oGuard2, 0.5);

    object oGuard3 = GetNearestObjectByTag("ks_griffon_guard", oPC, 3);
    SetLocalInt(oGuard3, "HF_EXIT_STARTED", 1);
    AssignCommand(oGuard3, SetFacingPoint(GetPosition(oDoor)));
    DestroyObject(oGuard3, 0.5);
}
