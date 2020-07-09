void main()
{
    object oEntering = GetEnteringObject();
    object oPC = GetFirstPC();
    object oRun;

    effect eFear = EffectFrightened();

    if (GetIsReactionTypeHostile(oEntering, oPC) == TRUE)
    {
        oRun = GetNearestObjectByTag("A3WP_SAFEWAYP", oEntering, 0);
        AssignCommand(oEntering, ClearAllActions(TRUE));
        AssignCommand(oEntering, ActionForceMoveToObject(oRun, TRUE, 5.0f, 10.0f));
    }
}
