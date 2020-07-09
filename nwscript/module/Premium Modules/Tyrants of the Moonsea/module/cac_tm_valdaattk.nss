//Valda and The Forsaken turn hostile and attack PC
#include "nw_i0_generic"

void main()
{
    object oForsaken;
    object oPC = GetPCSpeaker();
    object oValda = OBJECT_SELF;

    location lLoc = GetLocation(oValda);

    ChangeToStandardFaction(oValda, STANDARD_FACTION_HOSTILE);
    ActionDoCommand(DetermineCombatRound(oPC));

    oForsaken = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    while(oForsaken != OBJECT_INVALID)
    {
        if(GetTag(oForsaken) == "Forsaken")
        {
            ChangeToStandardFaction(oForsaken, STANDARD_FACTION_HOSTILE);
            AssignCommand(oForsaken, DetermineCombatRound(oPC));
        }
        oForsaken = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    }
}
