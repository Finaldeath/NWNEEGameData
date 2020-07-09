//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_innovate5
// DATE: February 27, 2006
// AUTH: Luke Scull
// NOTE: Update Arena journal then set int so that
//       Innovator's dialogue updates. Jump Onehand
//       to his waypoint by the pool in the Arena.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oWaypoint = GetObjectByTag("WP_Onehand_Jump3");
    object oOnehand = OBJECT_INVALID;

    // Jump existing creature to waypoint or create a new one
    oOnehand = GetObjectByTag("KalorOnehand");
    if (GetIsObjectValid(oOnehand))
    {
        AssignCommand(oOnehand, JumpToObject(oWaypoint));
    }
    else
    {
        CreateObject(OBJECT_TYPE_CREATURE, "kaloronehand", GetLocation(oWaypoint));
    }

    AddJournalQuestEntry("TheArena", 40, oPC);
    SetLocalInt(oPC, "innovator", 2);
}
