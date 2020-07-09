//::///////////////////////////////////////////////
//:: cac_poly_sigil
//:://////////////////////////////////////////////
/*
    Set how many Sigils has the PC activated.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

void main()
{
    object oPoly = OBJECT_SELF;
    object oModule = GetModule();
    int iSpark = GetLocalInt(oModule, "A3_SPARKLE");

    SetCustomToken(1505, IntToString(iSpark));
}
