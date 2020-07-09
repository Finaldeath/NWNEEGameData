//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_blackscrn
//:: DATE: March 24, 2019
//::////////////////////////////////////////////////////
//:: Trigger OnEnter
//:: Short black screen to set up stuff
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    if ( GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") != 1) )
    {
        float fDelay = GetLocalFloat(OBJECT_SELF, "duration");
        if (fDelay < 1.0f)
            fDelay = 1.0f;
        BlackScreen(oPC);
        DelayCommand(fDelay, FadeFromBlack(oPC));
    }
}
