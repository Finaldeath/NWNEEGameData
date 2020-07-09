
object CreatePoly(object oTarget);
void InitiatePoly(object oPC);

object GetValidPoly();
int IsPolySafe(object oCheck);
void FleePoly();

void InitiatePoly(object oPC)
{
    object oPoly = GetValidPoly();

    if (GetIsObjectValid(oPoly) == FALSE)
    {
        if (IsPolySafe(oPC) == TRUE)
        {
            oPoly = CreatePoly(oPC);
            DelayCommand(1.0f, AssignCommand(oPoly,
                ActionForceMoveToObject(oPC, TRUE, 1.0f, 3.0f)));

            DelayCommand(1.1f, AssignCommand(oPoly,
                ActionStartConversation(oPC)));
        }
    }
    else
    {
        AssignCommand(oPoly, ActionForceMoveToObject(oPC, TRUE, 1.0f, 3.0f));
        AssignCommand(oPoly, ActionStartConversation(oPC));
    }
}

object CreatePoly(object oTarget)
{
    object oPoly = OBJECT_INVALID;
    location lTarg = GetLocation(oTarget);

    if (IsPolySafe(oTarget) == TRUE)
    {
        oPoly = CreateObject(OBJECT_TYPE_CREATURE, "a1_poly", lTarg, TRUE);
    }

    return oTarget;
}

object GetValidPoly()
{
    return GetObjectByTag("a1_poly");
}

int IsPolySafe(object oCheck)
{
    location lCheck = GetLocation(oCheck);
    object oPC = GetFirstPC();
    object oCursor = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE,
        lCheck, FALSE, OBJECT_TYPE_CREATURE);

    int iFlag = TRUE;

    while(GetIsObjectValid(oCursor) == TRUE)
    {
        if (GetIsReactionTypeHostile(oPC, oCursor) == TRUE)
        {
            iFlag = FALSE;
        }

        oCursor = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE,
            lCheck, FALSE, OBJECT_TYPE_CREATURE);
    }

    return iFlag;
}

void FleePoly()
{
    effect eDisappear = EffectDisappear();
    object oPoly = GetValidPoly();

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisappear, oPoly);
}
