//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_hilrad4
//:: DATE: January 27, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Hilrad conversation, checks if Elventree attack
//:: is over, Astar is dead.
//::////////////////////////////////////////////////////

int StartingConditional()
{
    return (GetLocalInt(GetPCSpeaker(), "elventreeattacked") == 3);
}
