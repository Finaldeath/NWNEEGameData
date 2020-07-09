// player uses the ship's bilge pump to empty the water in the hold
// (elder water elemental attack in sidequest Muragh's Magnificent Machine)

void pumpWater(object oPC, object oPump)
{
    object oWater = GetNearestObjectByTag("tm_pl_grndwtb4x4", OBJECT_SELF);
    DestroyObject(oWater);
    SetUseableFlag(oPump, FALSE);
}

void main()
{
    object oPC = GetLastUsedBy();
    if (GetIsPC(oPC))
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
        DelayCommand(1.5, PlaySound("as_cv_pipeflush1"));
        DelayCommand(2.5, pumpWater(oPC, OBJECT_SELF));
    }
}
