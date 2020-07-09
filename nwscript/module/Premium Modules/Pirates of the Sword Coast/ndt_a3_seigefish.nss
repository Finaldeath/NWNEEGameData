//::///////////////////////////////////////////////
//:: ndt_a3_seigefish
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    One of the Elite Sahaugin have been killed
    once all three are dead trigger the ladder.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
void CountDown();

void main()
{
    object oModule = GetModule();
    AssignCommand(oModule, CountDown());
}

void CountDown()
{
    object oSelf = OBJECT_SELF;
    object oWPLadder = GetWaypointByTag("A3_SEIGELADDER_SWPN");
    object oCursor;

    int iDeadFish = GetLocalInt(oSelf, "A3_SEIGE_COUNTDOWN")+1;
    int iDoOnce = GetLocalInt(oSelf, "A3_SEIGE_END");
    int iCounter = 0;

    SetLocalInt(oSelf, "A3_SEIGE_COUNTDOWN", iDeadFish);
    if ((iDeadFish >= 3) && (iDoOnce == FALSE))
    {
        SetLocalInt(oSelf, "A3_SEIGE_END", TRUE);
        ExecuteScript("exe_a3_seige50", oSelf);

        oCursor = GetObjectByTag("a3_seigefish", iCounter);
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            DestroyObject(oCursor, 1.0f);

            iCounter++;
            oCursor = GetObjectByTag("a3_seigefish", iCounter);
        }

        CreateObject(OBJECT_TYPE_PLACEABLE, "a3_escape",
            GetLocation(oWPLadder), FALSE, "a3_seigeladder");
    }
}
