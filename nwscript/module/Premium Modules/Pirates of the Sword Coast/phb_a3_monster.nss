//::///////////////////////////////////////////////
//:: phb_a3_monster
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Controller for the Dweller boss in the
    Third act.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////
void Debug(string sMSG);
location GetClosestSpwnToPC(object oPC);
void DestroyMonster(object oMonster);
object CreateMonster(location lSpawn);

void main()
{
    object oPCFaction = GetFirstPC();
    object oMonster = OBJECT_INVALID;
    object oController = GetObjectByTag("a3_controller01");
    object oRoar;

    object oLeader = GetFactionLeader(oPCFaction);
    object oWeakest = GetFactionWeakestMember(oPCFaction);
    object oWorstAC = GetFactionWorstAC(oPCFaction);
    object oDamaged = GetFactionMostDamagedMember(oPCFaction);
    object oTarget;

    int iPlot = GetLocalInt(GetModule(), "A3_WATER");
    int iScaler = GetFactionAverageLevel(oPCFaction);
    int iHitPoints = GetLocalInt(oController, "CURRENT_HP");
    int iAttackType = Random(4);

    effect eCast1, eCast2, eMarker;

    location lSpawn, lTarget;

    if ((iHitPoints > 0) && (iPlot < 90))
    {
        switch (iAttackType)
        {
            case (0) :
                oTarget = oWorstAC;
                eCast1 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
                eCast2 = EffectVisualEffect(VFX_DUR_DARKNESS);
                eMarker = EffectVisualEffect(VFX_IMP_AURA_FEAR);

                lSpawn = GetClosestSpwnToPC(oTarget);
                lTarget = GetLocation(oTarget);
                oMonster = CreateMonster(lSpawn);
                oRoar = GetObjectByTag("snd_beastroar1");

                DelayCommand(5.0f, AssignCommand(oMonster, ActionCastSpellAtLocation(
                    SPELL_EVARDS_BLACK_TENTACLES, lTarget, METAMAGIC_ANY, TRUE,
                    PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            break;
            case (1) :
                oTarget = oDamaged;
                eCast1 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
                eCast2 = EffectVisualEffect(VFX_DUR_DARKNESS);
                eMarker = EffectVisualEffect(VFX_DUR_AURA_COLD);

                lSpawn = GetClosestSpwnToPC(oTarget);
                lTarget = GetLocation(oTarget);
                oMonster = CreateMonster(lSpawn);
                oRoar = GetObjectByTag("snd_beastroar2");

                DelayCommand(5.0f, AssignCommand(oMonster, ActionCastSpellAtLocation(
                    SPELL_ICE_STORM, lTarget, METAMAGIC_ANY, TRUE,
                    PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            break;
            case (2) :
                oTarget = oLeader;
                eCast1 = EffectVisualEffect(VFX_DUR_AURA_DISEASE);
                eCast2 = EffectVisualEffect(VFX_DUR_DARKNESS);
                eMarker = EffectVisualEffect(VFX_DUR_AURA_POISON);

                lSpawn = GetClosestSpwnToPC(oTarget);
                lTarget = GetLocation(oTarget);
                oMonster = CreateMonster(lSpawn);
                oRoar = GetObjectByTag("snd_beastroar3");

                DelayCommand(5.5f, AssignCommand(oMonster, ActionCastSpellAtLocation(
                    SPELL_STORM_OF_VENGEANCE, lTarget, METAMAGIC_ANY, TRUE,
                    PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            break;
            default :
                oTarget = oWeakest;
                eCast1 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
                eCast2 = EffectVisualEffect(VFX_DUR_DARKNESS);
                eMarker = EffectVisualEffect(VFX_IMP_AURA_NEGATIVE_ENERGY);

                lSpawn = GetClosestSpwnToPC(oTarget);
                lTarget = GetLocation(oTarget);
                oMonster = CreateMonster(lSpawn);
                oRoar = GetObjectByTag("snd_beastroar4");

                DelayCommand(5.0f, AssignCommand(oMonster, ActionCastSpellAtLocation(
                    SPELL_DARKNESS, lTarget, METAMAGIC_ANY, TRUE,
                    PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
            break;
        }

        SoundObjectPlay(oRoar);
        DelayCommand(5.0f, SoundObjectStop(oRoar));

        DelayCommand(1.5f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eMarker, lTarget, 5.0f));
        DelayCommand(0.5f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eCast1, lSpawn, 2.0f));
        DelayCommand(0.5f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eCast2, lSpawn, 6.0f));
        DelayCommand(8.0f, DestroyMonster(oMonster));

        //Debug("phb_a3_monster '" + GetName(oMonster)
        //    + "' fired; Running attack '" + IntToString(iAttackType)
        //    + "' on PC '" + GetName(oTarget) + "'");


    }
}

location GetClosestSpwnToPC(object oPC)
{
    object oWPA = GetWaypointByTag("WP_BEASTSPWN_A");
    object oWPB = GetWaypointByTag("WP_BEASTSPWN_B");
    object oWPC = GetWaypointByTag("WP_BEASTSPWN_C");
    object oWPD = GetWaypointByTag("WP_BEASTSPWN_D");

    float fDistA = GetDistanceBetween(oPC, oWPA);
    float fDistB = GetDistanceBetween(oPC, oWPB);
    float fDistC = GetDistanceBetween(oPC, oWPC);
    float fDistD = GetDistanceBetween(oPC, oWPD);

    location lReturn = GetLocation(oWPA);

    if ((fDistA < fDistB) && (fDistA < fDistC) && (fDistA < fDistD))
    {
        lReturn = GetLocation(oWPA);
        AssignCommand(oWPA, SetFacingPoint(GetPosition(oPC)));
    }
    else if ((fDistB < fDistA) && (fDistB < fDistC) && (fDistB < fDistD))
    {
        lReturn = GetLocation(oWPB);
        AssignCommand(oWPB, SetFacingPoint(GetPosition(oPC)));
    }
    else if ((fDistC < fDistA) && (fDistC < fDistB) && (fDistC < fDistD))
    {
        lReturn = GetLocation(oWPC);
        AssignCommand(oWPC, SetFacingPoint(GetPosition(oPC)));
    }
    else if ((fDistD < fDistA) && (fDistD < fDistB) && (fDistD < fDistC))
    {
        lReturn = GetLocation(oWPD);
        AssignCommand(oWPD, SetFacingPoint(GetPosition(oPC)));
    }

    return lReturn;
}

object CreateMonster(location lSpawn)
{
    object oController = GetObjectByTag("a3_controller01");
    object oMonster;

    effect eMonster = EffectVisualEffect(VFX_FNF_WEIRD);
    effect eDamage;

    int iHitPoints, iMaxHitPoints;

    oMonster = CreateObject(OBJECT_TYPE_PLACEABLE, "a3_monster", lSpawn);

    iMaxHitPoints = GetMaxHitPoints(oMonster);
    iHitPoints = GetLocalInt(oController, "CURRENT_HP");

    eDamage = EffectDamage(iMaxHitPoints - iHitPoints);

    AssignCommand(oMonster, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eMonster, lSpawn, 5.0f));
    AssignCommand(oMonster, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oMonster));

    //Debug("Created Monster '" + GetName(oMonster)
    //    + "' with iMaxHitPoints '" + IntToString(iMaxHitPoints)
    //    + "' and iHitPoints '" + IntToString(iHitPoints) + "'");

    return oMonster;
}

void DestroyMonster(object oMonster)
{
    object oController = GetObjectByTag("a3_controller01");
    int iHitPoints = GetCurrentHitPoints(oMonster);
    int iOldHitPoints = GetLocalInt(oController, "CURRENT_HP");

    SetLocalInt(oController, "CURRENT_HP", iHitPoints);
    DestroyObject(oMonster);

    if (iOldHitPoints > iHitPoints)
    {
        DelayCommand(80.0f, ExecuteScript("phb_a3_monster", oController));
    }
    else
    {
        DelayCommand(15.0f, ExecuteScript("phb_a3_monster", oController));
    }
}

void Debug(string sMSG)
{
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC) == TRUE)
    {
        //SendMessageToPC(oPC, sMSG);
        oPC = GetNextPC();
    }
}
