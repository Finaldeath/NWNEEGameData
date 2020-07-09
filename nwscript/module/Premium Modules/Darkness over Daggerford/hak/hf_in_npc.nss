// surrender to the player
void SurrenderToPlayer(object oPC)
{
    // stop the fight
    ClearAllActions();
    AssignCommand(oPC, ClearAllActions());
    SurrenderToEnemies();
    ClearPersonalReputation(oPC, OBJECT_SELF);

    // reset my faction to its original value
    location lCopyLoc = GetLocation(GetWaypointByTag("hf00_wp_temp_spawn_location"));
    object oCopyOfMe = CreateObject(OBJECT_TYPE_CREATURE, GetResRef(OBJECT_SELF), lCopyLoc);
    ChangeFaction(OBJECT_SELF, oCopyOfMe);
    AdjustReputation(oPC, OBJECT_SELF, 50);
    DestroyObject(oCopyOfMe);

    if (!GetIsEnemy(oPC, OBJECT_SELF))
    {
        // prevent PC or pals from accidentally killing me
        SetPlotFlag(OBJECT_SELF, TRUE);
        DelayCommand(10.0, SetPlotFlag(OBJECT_SELF, FALSE));
    }
}

// check if the timer on an object has expired
int IsTimerExpired(object oNPC, int nHours)
{
    string sYear = IntToString(GetCalendarYear());
    string sYearShort = sYear;
    if (GetStringLength(sYear) >= 2)
    {
        string sYearShort = GetStringRight(sYear, 2);
    }
    int nYearShort = StringToInt(sYearShort);
    int nCurTime = nYearShort*1000000 + GetCalendarMonth()*10000 + GetCalendarDay()*100 + GetTimeHour();
    int nLastTime = GetLocalInt(oNPC, "HF_TIMER_LAST_FIRED");
    if ((nCurTime - nLastTime) > nHours)
    {
        SetLocalInt(oNPC, "HF_TIMER_LAST_FIRED", nCurTime);
        return(TRUE);
    }
    return(FALSE);
}

// turn to face an object
void FaceObject(object oSubject, object oLookAt)
{
    AssignCommand(oSubject, SetFacingPoint(GetPosition(oLookAt)));
}

// reset common faction reputations
void ResetFactionReputation(object oMaster, object oChangeMe)
{
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oMaster) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oChangeMe);
    }

    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oMaster) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oChangeMe);
    }

    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oMaster) <= 10)
    {
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oChangeMe);
    }
}

// make an NPC more of a match for a player; doesn't work on players
void BoostUpCreature(object oNPC, object oPC)
{
    if (GetIsPC(oNPC))
    {
        return;
    }
    int nDelta = GetHitDice(oPC) - GetHitDice(oNPC);
    if (nDelta > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(d8(nDelta)), oNPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSavingThrowIncrease(SAVING_THROW_ALL, nDelta/2), oNPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackIncrease(nDelta/2), oNPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nDelta/2), oNPC);
    }
}

// adjust the level of a creature; i don't trust it to work properly
void LevelUpCreature(object oCreature, int nClass, int nLevels = 0)
{
    int i;
    for (i=1; i<nLevels; i++)
    {
        LevelUpHenchman(oCreature, nClass, TRUE);
    }
}

// teleport the party to a given location
void TeleportToMapLocation(object oPC, location lLoc, int nFade=FALSE)
{
    // add fade effect
    float nDelay = 0.0;
    if (nFade)
    {
        FadeToBlack(oPC);
        nDelay = 2.0;
        DelayCommand(nDelay+0.5, FadeFromBlack(oPC));
    }

    // move all party members
    object oParty = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        DelayCommand(nDelay, AssignCommand(oParty, JumpToLocation(lLoc)));
        oParty = GetNextFactionMember(oPC, TRUE);
    }

    // move all non-party members such as familiars
    oParty = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        DelayCommand(nDelay, AssignCommand(oParty, JumpToLocation(lLoc)));
        oParty = GetNextFactionMember(oPC, FALSE);
    }

    // move the player
    DelayCommand(nDelay, AssignCommand(oPC, JumpToLocation(lLoc)));
}

// teleport the party to a given location
void TeleportToWaypoint(object oPC, string sWP, int nFade=FALSE)
{
    object oWP = GetObjectByTag(sWP);
    if (!GetIsObjectValid(oWP))
    {
        SendMessageToPC(GetFirstPC(), "ERROR: invalid teleport waypoint: " + sWP);
        return;
    }
    TeleportToMapLocation(oPC, GetLocation(oWP), nFade);
}

// teleport the party to a given object
void TeleportToObject(object oPC, object oDst, int nFade=FALSE)
{
    if (!GetIsObjectValid(oDst))
    {
        SendMessageToPC(GetFirstPC(), "ERROR: invalid teleport destination: " + GetTag(oDst));
        return;
    }
    TeleportToMapLocation(oPC, GetLocation(oDst), nFade);
}

//void main() {}
