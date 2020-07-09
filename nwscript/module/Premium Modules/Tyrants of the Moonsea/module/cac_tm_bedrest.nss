// party rests (meditates) at the foot of a nearby bed

void RestInNearbyBed(object oPC, int nMoveToBed)
{
    object oBed = GetNearestObjectByTag("WP_BED_REST");
    vector vPos = GetPosition(oBed);
    if (nMoveToBed)
    {
        ActionMoveToObject(oBed);
    }
    ActionDoCommand(SetFacingPoint(vPos));
    ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 4.0);
    ActionDoCommand(ForceRest(oPC));
}

void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, RestInNearbyBed(oPC, TRUE));

    int n = 1;
    object oHench = GetHenchman(oPC, n);
    while (GetIsObjectValid(oHench))
    {
        AssignCommand(oHench, ClearAllActions(TRUE));
        AssignCommand(oHench, RestInNearbyBed(oHench, FALSE));
        oHench = GetHenchman(oPC, ++n);
    }
}
