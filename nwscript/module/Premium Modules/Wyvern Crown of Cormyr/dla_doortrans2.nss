// dla_doortrans2
// February 2006
// B W-Husey
// Sets up which barrow/camp door goes where. Barrows: First goes to treaure chambers, second to ring chamber.
// Encampment - door goes back to the relevant 'On the Road' area.This is the command
// for the return doors. Their destinations are set in dla_doortrans1 & 3

#include "cu_functions"
void main()
{
    // Declare variables needed
    object oDoor = OBJECT_SELF;
    object oDestination;
    object oPC = GetEnteringObject();  //Replaced GetLastUsedBy as this returns null on a transition with no door for some reason. (Thanks Mirko/TK!)
    oDestination = GetObjectByTag(GetLocalString(oDoor,"sMyTarget"));
    AssignCommand(oPC,JumpToObject(oDestination));
}
