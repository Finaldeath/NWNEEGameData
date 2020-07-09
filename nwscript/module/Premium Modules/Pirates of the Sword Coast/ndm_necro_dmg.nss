//::///////////////////////////////////////////////
//:: Name ndm_necro_dmg
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Damage script for the Necromatic
    Pirate "Kolmarr".
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: April 16, 2005
//:://////////////////////////////////////////////

const string sSuccess1 = "Blimey, that stings! Time to steal some life-blood from me crew!";
const string sSuccess2 = "There be no stoppin' a Captain who keeps a loyal crew!";
const string sSuccess3 = "With a crew like this, they'll call me Dread Pirate Kolmarr in no time!";
const string sSuccess4 = "A pox on your sorry soul, sailor, but I be needin' that lifeblood o' yours!";

const string sFailed1 = "Arrr, ye mutinous wretch - Ye've laid low me loyal crew!";

void SpeakSuccess();
void SpeakFail();

void SpeakSuccess()
{
    int iRand = Random(6);

    switch (iRand)
    {
        case 0 :
            SpeakString(sSuccess1);
        break;
        case 1 :
            SpeakString(sSuccess2);
        break;
        case 2 :
            SpeakString(sSuccess3);
        break;
        case 3 :
            SpeakString(sSuccess4);
        break;
    }
}

void SpeakFail()
{
    SpeakString(sFailed1);
}

void main()
{
    object oModule = GetModule();
    object oKolmarr = OBJECT_SELF;
    object oCursor = OBJECT_INVALID;
    object oBestTarg = OBJECT_INVALID;

    effect eBeam = EffectBeam(VFX_BEAM_SILENT_LIGHTNING, oKolmarr, BODY_NODE_HAND);

    effect eVFXSource = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eVFXTarg = EffectVisualEffect(VFX_IMP_HARM);

    int iDeBounce = GetLocalInt(oKolmarr, "ndm_necro_dmg");
    int iCurrentHP = GetCurrentHitPoints(oKolmarr);
    int iMaximumHP = GetMaxHitPoints(oKolmarr);
    int iStealHP = iMaximumHP - iCurrentHP + 10;
    int iCounter = 0;

    effect eHeal = EffectHeal(iStealHP);
    effect eDamage = EffectDamage(iStealHP);
    string sMonster = "";

    float fDistance = 1000.0f;
    float fBestDistance = 1000.0f;

    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    // Kolmarr Drains a crewman.
    if (((iMaximumHP / 2) > iCurrentHP) && (iDeBounce == FALSE))
    {
        SetLocalInt(oKolmarr, "ndm_necro_dmg", TRUE);
        //SendMessageToPC(GetFirstPC(), "Kolmarr's Special Attack Fired!");

        sMonster = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter + 1));
        oCursor = GetObjectByTag(sMonster);

        while (iCounter <= 5)
        {
            fDistance = GetDistanceToObject(oCursor);
            if ((GetIsObjectValid(oCursor) == TRUE) && (GetIsDead(oCursor) == FALSE)
              && (fDistance < fBestDistance))
            {
                fBestDistance = fDistance;
                oBestTarg = oCursor;
            }

            sMonster = GetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iCounter + 1));
            oCursor = GetObjectByTag(sMonster);

            iCounter++;
        }

        if (GetIsObjectValid(oBestTarg) == TRUE)
        {
            //SendMessageToPC(GetFirstPC(), "Kolmarr special cast on " + GetName(oBestTarg));
            SpeakSuccess();

            AssignCommand(oKolmarr, SetFacingPoint(GetPosition(oCursor)));
            AssignCommand(oKolmarr, PlayAnimation(ANIMATION_LOOPING_CONJURE1));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oBestTarg, 2.0f));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXTarg, oBestTarg));
            DelayCommand(1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXSource, oKolmarr));

            DelayCommand(1.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oBestTarg));
            DelayCommand(1.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oKolmarr));

            DelayCommand(5.0, SetLocalInt(oKolmarr, "ndm_necro_dmg", FALSE));
        }
        else
        {
            SpeakFail();
            //SendMessageToPC(GetFirstPC(), "No Suitable targets!");
            ExecuteScript("nw_c2_default6", OBJECT_SELF);
        }
    }
    else
    {
        //--------------------------------------------------------------------------
        // Execute old NWN default AI code
        //--------------------------------------------------------------------------
        ExecuteScript("nw_c2_default6", OBJECT_SELF);
    }
}
