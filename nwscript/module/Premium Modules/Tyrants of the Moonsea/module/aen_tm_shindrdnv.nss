//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: aen_tm_shindrdnv
//:: DATE: December 04, 2018
//::////////////////////////////////////////////////////
//:: AreaOnEnter: Shind Road - Narrow Valley
//:: Short Black screen to set up stuff
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    if ( GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") != 1) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);

        // [OS-740] - these three lines were causing the controller to freeze?
        //StopFade(oPC);
        //BlackScreen(oPC);
        //DelayCommand(2.0f, StopFade(oPC));
    }
}
