//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_noric
// DATE: October 10, 2005
// AUTH: Luke Scull
// NOTE: Noric initiates dialogue with PC (in cutscene
//       mode).
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    object oNoric = GetObjectByTag("DeputyNoric");

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0))
    {
        AssignCommand(oPC, ClearAllActions());
        SetCutsceneMode(oPC, TRUE);
        AssignCommand(oPC, SetCameraFacing(270.0, 15.0, 50.0));
        AssignCommand(oNoric, ClearAllActions());
        DelayCommand(0.2, AssignCommand(oNoric, ActionMoveToObject(oPC, FALSE, 3.0f)));
        DelayCommand(1.0, AssignCommand(oNoric, ActionStartConversation(oPC)));

        SetLocalInt(OBJECT_SELF, "fired", 1);
    }
}
