//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: pck_tm_casino_w0
//:: DATE: April 14, 2019
//::////////////////////////////////////////////////////
//:: Mulmaster Casino - Wheel of Fortune
//::
//:: When close: Make the player examine the wheel on
//::             first click.
//:: When far away: Make him walk/run to it, instead of
//::                opening it.
//::////////////////////////////////////////////////////


void main()
{
    object oPC = GetPlaceableLastClickedBy();
    object oWheel = OBJECT_SELF;

    if (GetIsPC(oPC) && (GetLocalInt(oWheel, "nDone") < 1))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        if (GetDistanceBetween(oPC, oWheel) < 7.0f)
        {
            SetLocalInt(oWheel, "nDone", 1);

            DelayCommand(0.5f, AssignCommand(oPC, ActionExamine(oWheel)));
        }
        else
        {
            DelayCommand(0.5f, AssignCommand(oPC, ActionMoveToObject(oWheel, TRUE)));
        }
    }
}
