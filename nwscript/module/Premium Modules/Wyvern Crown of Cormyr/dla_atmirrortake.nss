/*
    DLA_ATMIRRORTAKE.nss
    ActionTaken when picking silver mirror placeable
    "gaoneng" Erick            March 27, 2006
*/

#include "cu_puzzles"

void main()
{
    gn_RemoveMirror(GetPCSpeaker(), OBJECT_SELF);
}


/*
// January 2006
// B W-Husey
// The PC picks up a silver mirror. Switch off the plot state and add one to the inventory.

#include "cu_puzzles"
void main()
{
    object oCentre = GetObjectByTag("MirrorChecker");
    object oPC = GetPCSpeaker();
    CreateItemOnObject("silvermirror",oPC);
    SetPlotFlag(OBJECT_SELF,FALSE); // Erick sez - unnecessary, DestroyObject ignores plot state
    AssignCommand(oCentre,DelayCommand(1.5,MirrorCheck(oPC)));
    DestroyObject(OBJECT_SELF,0.5);
}
