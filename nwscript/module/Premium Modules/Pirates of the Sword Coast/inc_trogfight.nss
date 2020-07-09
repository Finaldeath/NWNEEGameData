//::///////////////////////////////////////////////
//:: inc_trogfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Handler functions for the troglodyte fire
    sequence.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

int IsFireActive();
void DeactivateFire();
void ActivateFire();
void SlowTrogs();
void ReviveTrogs();
void CallFireTrogs();
int DifficultyScaler();
void EnrageTrogs();

int IsFireActive()
{
    object oSelf = GetObjectByTag("a1_trogfire");
    int iReturn = GetLocalInt(oSelf, "ACTIVE_FIRE");

    return iReturn;
}

void DeactivateFire()
{
    object oSelf = GetObjectByTag("a1_trogfire");
    object oFire1 = GetNearestObjectByTag("a1_firelrg", oSelf, 1);
    object oFire2 = GetNearestObjectByTag("a1_firelrg", oSelf, 2);
    object oFire3 = GetNearestObjectByTag("a1_firelrg", oSelf, 3);
    object oFire4 = GetNearestObjectByTag("a1_firelrg", oSelf, 4);

    object oFireSound = GetObjectByTag("a1_scrdfr_snd");

    SoundObjectStop(oFireSound);

    AssignCommand(oFire1, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    AssignCommand(oFire2, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    AssignCommand(oFire3, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    AssignCommand(oFire4, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    SetLocalInt(oSelf, "ACTIVE_FIRE", FALSE);
}

void ActivateFire()
{
    object oSelf = GetObjectByTag("a1_trogfire");
    object oFire1 = GetNearestObjectByTag("a1_firelrg", oSelf, 1);
    object oFire2 = GetNearestObjectByTag("a1_firelrg", oSelf, 2);
    object oFire3 = GetNearestObjectByTag("a1_firelrg", oSelf, 3);
    object oFire4 = GetNearestObjectByTag("a1_firelrg", oSelf, 4);

    object oFireSound = GetObjectByTag("a1_scrdfr_snd");

    SoundObjectPlay(oFireSound);

    AssignCommand(oFire1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    AssignCommand(oFire2, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    AssignCommand(oFire3, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    AssignCommand(oFire4, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

    SetLocalInt(oSelf, "ACTIVE_FIRE", TRUE);
}

void SlowTrogs()
{
    object oSelf = GetObjectByTag("a1_trogfire");
    object oArea = GetArea(oSelf);
    object oCursor;

    effect eSlow = EffectSlow();
    effect eACDcr = EffectACDecrease(2);
    effect eATKDcr = EffectAttackDecrease(2);

    oCursor = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        if ((GetRacialType(oCursor) == RACIAL_TYPE_HUMANOID_REPTILIAN)
         && (GetIsPC(oCursor) == FALSE) && (GetTag(oCursor) != "a1_hench_garm"))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oCursor);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eACDcr, oCursor);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eATKDcr, oCursor);
        }

        oCursor = GetNextObjectInArea(oArea);
    }
}

void ReviveTrogs()
{
    object oSelf = GetObjectByTag("a1_trogfire");
    object oArea = GetArea(oSelf);
    object oCursor = GetFirstObjectInArea(oArea);

    effect eCursor = EffectSlow();

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        if ((GetRacialType(oCursor) == RACIAL_TYPE_HUMANOID_REPTILIAN)
         && (GetIsPC(oCursor) == FALSE) && (GetTag(oCursor) != "a1_hench_garm"))
        {
            eCursor = GetFirstEffect(oCursor);

            while (GetIsEffectValid(eCursor) == TRUE)
            {
                if ((GetEffectType(eCursor) == EFFECT_TYPE_SLOW)
                  || (GetEffectType(eCursor) == EFFECT_TYPE_AC_DECREASE)
                  || (GetEffectType(eCursor) == EFFECT_TYPE_ATTACK_DECREASE))
                {
                    DelayCommand(0.1f, RemoveEffect(oCursor, eCursor));
                }
                eCursor = GetNextEffect(oCursor);
            }
        }
        oCursor = GetNextObjectInArea(oArea);
    }
}

void CallFireTrogs()
{
    object oSelf = GetObjectByTag("a1_trogfire");
    object oTarget = GetWaypointByTag("A1_TROGFIRE");
    object oArea = GetArea(oSelf);
    object oCursor;

    int iScaler = DifficultyScaler();
    int iCounter = 1;

    oArea = GetArea(oSelf);
    oCursor = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE,
            RACIAL_TYPE_HUMANOID_REPTILIAN, oSelf, iCounter);

    while ((GetIsObjectValid(oCursor) == TRUE) && (iCounter < iScaler))
    {
        if ((GetIsPC(oCursor) == FALSE) && (GetTag(oCursor) != "a1_hench_garm")
          && (GetIsInCombat(oCursor) == FALSE))
        {
            AssignCommand(oCursor, ClearAllActions(TRUE));
            AssignCommand(oCursor, SpeakString("The Sacred Fire!"));
            AssignCommand(oCursor, ActionMoveToObject(oTarget, TRUE, 1.0f));
        }
        else
        {
            iScaler++;
        }

        iCounter++;

        oCursor = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE,
            RACIAL_TYPE_HUMANOID_REPTILIAN, oSelf, iCounter);
    }
}


int DifficultyScaler()
{
    int iReturn;

    switch (GetGameDifficulty())
    {
        case GAME_DIFFICULTY_CORE_RULES:
        case GAME_DIFFICULTY_DIFFICULT:
            iReturn = 5;
        break;

        case GAME_DIFFICULTY_NORMAL:
            iReturn = 4;
        break;

        case GAME_DIFFICULTY_EASY:
        case GAME_DIFFICULTY_VERY_EASY:
        default:
            iReturn = 3;
        break;
    }

    return iReturn;
}
