// onEnter script to autosave game

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nAreaSaved") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nAreaSaved", 1);
            DoSinglePlayerAutoSave();
        }
    }
}
