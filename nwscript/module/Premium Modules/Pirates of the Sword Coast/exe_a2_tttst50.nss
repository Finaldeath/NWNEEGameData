//::///////////////////////////////////////////////
//:: exe_a2_tttst50
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC uses the IOU on langer.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oCursor = GetFirstPC();
    object oIOU;

    SetLocalInt(oModule, "A2_TTTST", 50);
    AddJournalQuestEntry("a2_tttst", 50, oCursor, TRUE, TRUE);

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        oIOU = GetItemPossessedBy(oCursor, "a2_ioutatt");

        // Does a IOU Falstaff exist in the PC's inventory?
        if (GetIsObjectValid(oIOU) == TRUE)
        {
            DestroyObject(oIOU);
        }

        oCursor = GetNextPC();
    }
}
