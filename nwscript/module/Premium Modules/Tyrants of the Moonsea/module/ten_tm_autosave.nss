//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ten_tm_autosave
//:: DATE: March 24, 2019
//::////////////////////////////////////////////////////
//:: Trigger OnEnter
//:: Auto save
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    if ( GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") != 1) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);
        DoSinglePlayerAutoSave();
    }
}
