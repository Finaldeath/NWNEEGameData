// B G P Hughes (B W-Huesy)
// August 2005
// Area transition script for use on transitions that take the party from one area to another
// The destinations available are controlled through the conversation dialogue variables
// as is the time and food (gold) cost of travel, which is dependant on whether the PC
// is on foot or mounted.
// Before the dialogue is fired up, this script checks the local variables and adjusts some of them dependant
// on the plot state of other variables, listed below:
/*
    nMainPlot =     1, no travel to any Wyvernwater, any Polter, Hullack Forest or Barrows
    nMainPlot =     2, no travel to any Wyvernwater, any Polter. Tournaments. Thunderstone?
    nMainPlot =     3, no travel to any Wyvernwater, Hullack Forest or Barrows. Tournaments.
    nMainPlot =     4, no travel to any Polter, Hullack Forest or Barrows, Tournaments.
    nMainPlot =     5, no travel to any Polter, Hullack Forest or Barrows,Tournaments.
    nMainPlot =     6, no travel to any Wyvernwater, any Polter, Hullack Forest or Barrows.
    nMainPlot =     7, no travel to any Wyvernwater, any Polter, Hullack Forest or Barrows,Tournaments.
    nMainPlot =     8, Only Thunderstone non-tournament areas.
    In any event some areas (farm, morfen, on the road) are only accessible form the testing conversation
    as they are one way in the module.
*/


void main()
{
    object oPC = GetClickingObject();
//    AssignCommand(GetClickingObject(),ClearAllActions());
    BeginConversation("Transitiontest",GetClickingObject());
//    ActionStartConversation(OBJECT_SELF,"Transition");
}
