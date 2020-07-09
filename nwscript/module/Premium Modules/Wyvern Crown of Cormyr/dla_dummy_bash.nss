void AnnounceDummyTime()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetFirstPC();
    object oDummy = GetObjectByTag("dla_strengthdummy");
    int nStartHP = GetLocalInt(oPC,"nDummyHPStart");
    int nHitPoints = GetCurrentHitPoints(oDummy);
    int nDamage = nStartHP - nHitPoints;
    int nRecord = GetLocalInt(oDummy,"nDummyDamageRecord");
    string sName = GetName(oDummy);
    string sChamp = GetLocalString(oDummy,"sDummyChamp");
    object oReplace;
    location lLoc = GetLocation(oDummy);
    if(GetLocalInt(oPC,"nDummyDQ"))
    {
        DeleteLocalInt(oPC,"nDummyDQ");
        DeleteLocalInt(oSelf,"nDummySequence");
        DeleteLocalInt(oPC,"nDummyContestActive");
        DeleteLocalInt(oPC,"nDummyDamage");
        DeleteLocalInt(oPC,"nDummyHPStart");
        return;
    }
    int nSequence = GetLocalInt(oSelf,"nDummySequence");
    nSequence--;
    SetLocalInt(oSelf,"nDummySequence",nSequence);
    if(nSequence%5==0 || nSequence<6)
    {
        FloatingTextStringOnCreature(IntToString(nDamage),oPC);
        AssignCommand(oSelf,ActionSpeakString(IntToString(nSequence)+" seconds to go!"));
    }
    if(nSequence<1)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oSelf,ActionSpeakString("Time's up!"));
        DeleteLocalInt(oSelf,"nDummySequence");
        DeleteLocalInt(oPC,"nDummyContestActive");
        SetLocalInt(oPC,"nDummyDamage",nDamage);
        if(nDamage>nRecord)
        {
            SetLocalInt(oPC,"nDummyResult",2);
        }
        else
        {
            SetLocalInt(oPC,"nDummyResult",1);
        }
        //respawn the dummy so we don't run out of hitpoints
        DestroyObject(oDummy,0.1);
        oReplace = CreateObject(OBJECT_TYPE_PLACEABLE,"dla_strengthdumm",lLoc);
        SetLocalInt(oReplace,"nDummyDamageRecord",nRecord);
        SetLocalString(oReplace,"sDummyChamp",sChamp);
        SetName(oReplace,sName);
        AssignCommand(oSelf, ActionStartConversation(oPC));
        return;
    }
    DelayCommand(1.0f, AnnounceDummyTime());
}
void main()
{
    object oPC = GetPCSpeaker();
    object oDummy = GetObjectByTag("dla_strengthdummy");
    int nHitPoints = GetCurrentHitPoints(oDummy);
    SetLocalInt(oPC,"nDummyHPStart",nHitPoints);
    SetLocalInt(OBJECT_SELF,"nDummySequence",30);
    SetLocalInt(oPC,"nDummyContestActive",TRUE);
    SetLocalInt(oPC,"nHasPlayedDummyOnce",TRUE);
    DeleteLocalInt(oPC,"nDummyDamage");
    AnnounceDummyTime();
}
