//::///////////////////////////////////////////////
//:: inc_polyflee
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will cause the owner to fly away
    and come back to a safe lcoation later.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////

const string sEscape01 = "Achtung! Peligro!! Danger!!! Rrrawk!!!!";
const string sEscape02 = "Rrrawk! Abort! Abort!";
const string sEscape03 = "Poly, this is Wing Commander One, Rrrawk! Pull up! Pull up!";
const string sEscape04 = "Abandon ship! Rrrawk! Abandon ship, over!";
const string sEscape05 = "Rrrawk! Return to base! Return to base, over!";

const string sReturn01 = "Rrrawk! Heeeere's Poly!";
const string sReturn02 = "Incoming!!! Rrrawk!";
const string sReturn03 = "Rrrawk! Requesting permission to land, over!";
const string sReturn04 = "Rrrawk! Hey, keep it down. I was trying to sleep!";
const string sReturn05 = "So, come here often? Rrrawk!";

void Respawn (string sResRef);
void VerifySpawn(object oSpawn, string sResRef);
int SafeCheck(object oTarget);

string RandReturn();
string RandEscape();
void PolyFlee(object oPoly, int bNoTalk = FALSE);

void PolyFlee(object oPoly, int bNoTalk = FALSE)
{
    // JE: Failsafe in case oPoly isn't valid
    if(!GetIsObjectValid(oPoly)) return;

    object oFirstPC = GetFirstPC();
    string sResRef = GetResRef(oPoly);
    string sRandEscape = "";
    effect eDisapear = EffectDisappear();
    int iDoOnce = GetLocalInt(oPoly, "POLY_FLEE");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oPoly, "POLY_FLEE", TRUE);

        AssignCommand(oPoly, ClearAllActions(TRUE));
        AssignCommand(GetModule(), DelayCommand(10.0f, Respawn(sResRef)));

        if(!bNoTalk)
        {
            sRandEscape = RandEscape();
            if (sRandEscape != "")
            {
                AssignCommand(oPoly, SpeakString(sRandEscape));
            }
        }
        else
        {
            SetLocalInt(GetModule(), "POLY_NOTALK", TRUE);
        }

        DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisapear, oPoly));
    }
}

string RandReturn()
{
    string sReturn = "";
    switch (Random(10))
    {
        case 1:  sReturn = sReturn01;
        break;
        case 2:  sReturn = sReturn02;
        break;
        case 3:  sReturn = sReturn03;
        break;
        case 4:  sReturn = sReturn04;
        break;
        case 5:  sReturn = sReturn05;
        break;
        default :  sReturn = "";
        break;
    }

    return sReturn;
}

string RandEscape()
{
    string sReturn = "";
    switch (Random(10))
    {
        case 1:  sReturn = sEscape01;
        break;
        case 2:  sReturn = sEscape02;
        break;
        case 3:  sReturn = sEscape03;
        break;
        case 4:  sReturn = sEscape04;
        break;
        case 5:  sReturn = sEscape05;
        break;
        default :  sReturn = "";
        break;
    }

    return sReturn;
}

void Respawn (string sResRef)
{
    object oTarget = GetFirstPC();
    object oModule = GetModule();
    object oPoly = GetObjectByTag("a1_poly");
    object oCursor, oSpawn;

    int iSafe = FALSE;
    location lTarg;

    // if poly is still around after he was supposed to flee
    // Clear his flee debounce flag.
    if (GetIsObjectValid(oPoly) == TRUE)
    {
        SetLocalInt(oPoly, "POLY_FLEE", FALSE);
    }
    else if (sResRef != "")
    {
        while ((GetIsObjectValid(oTarget) == TRUE) && (iSafe == FALSE))
        {
            //SendMessageToPC(oTarget, "**Checking for safe conditions.");
            iSafe = SafeCheck(oTarget);
            if (iSafe == FALSE)
            {
                oTarget = GetNextPC();
            }
        }

        if (iSafe == TRUE)
        {
            lTarg = GetLocation(oTarget);
            SetLocalObject(oModule, "POLY_FOLLOW", oTarget);
            //SendMessageToPC(oTarget, "**Creating poly RESREF:'"+sResRef+"'");
            oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lTarg, TRUE);

            DelayCommand(2.0f, VerifySpawn(oSpawn, sResRef));
        }
        else
        {
            DelayCommand(5.0f, Respawn(sResRef));
        }
    }
}

void VerifySpawn(object oSpawn, string sResRef)
{
    effect eGhost = EffectCutsceneGhost();
    effect eFlee = EffectAreaOfEffect(AOE_PER_CUSTOM_AOE, "exe_polyflee");
    string sRandReturn = "";

    if (GetIsObjectValid(oSpawn) == TRUE)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oSpawn);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFlee, oSpawn);

        // If Poly fled with the bNoTalk parameter specified, then don't say
        // anything when returning either. We'll reset the variable though,
        // so it doesn't affect Poly any further.
        if(GetLocalInt(GetModule(), "POLY_NOTALK"))
        {
            DeleteLocalInt(GetModule(), "POLY_NOTALK");
        }
        else
        {
            sRandReturn = RandReturn();
            if (sRandReturn != "")
            {
                AssignCommand(oSpawn, SpeakString(sRandReturn));
            }
        }
    }
    else
    {
        //SendMessageToPC(GetFirstPC(), "**Creation Failed");
        DestroyObject(oSpawn, 0.5f);
        DelayCommand(5.0f, Respawn(sResRef));
    }
}

int SafeCheck (object oTarget)
{
    object oCursor;

    int iReturn = TRUE;
    location lTarg;

    if ((GetIsInCombat(oTarget) == FALSE) && (GetCutsceneMode(oTarget) == FALSE))
    {
        lTarg = GetLocation(oTarget);
        // check if lTarg is even a valid location
        if(!GetIsObjectValid(GetAreaFromLocation(lTarg))) iReturn = FALSE;

        oCursor = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lTarg, FALSE);
        while ((GetIsObjectValid(oCursor) == TRUE) && (iReturn == TRUE))
        {
            iReturn = (GetIsEnemy(oTarget, oCursor) == FALSE);
            oCursor = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lTarg);
        }
    }
    else
    {
        iReturn = FALSE;
    }

    return iReturn;
}
