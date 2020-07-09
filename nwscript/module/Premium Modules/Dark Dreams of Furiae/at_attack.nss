void main()
{
    object oTarget = GetPCSpeaker();
    AdjustReputation(oTarget, OBJECT_SELF,-100);
    ActionAttack(oTarget);
}
