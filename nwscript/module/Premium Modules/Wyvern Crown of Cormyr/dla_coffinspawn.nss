//::///////////////////////////////////////////////
//:: dla_coffinspawn.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Vampire Coffin User Defined script.
    Spawns a new vampire after a 30 second delay
    if the coffin exists.
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:  January 2002
//:://////////////////////////////////////////////
void SpawnVampire(string sTemplate, location lLoc)
{
    object oVamp = CreateObject(OBJECT_TYPE_CREATURE,sTemplate,lLoc);
    object oPC = GetFirstPC();
    if(GetDistanceBetween(oPC, oVamp)<10.0)
    {
        AssignCommand(oVamp, ActionAttack(oPC));
    }
    else
    {
        AssignCommand(oVamp, ActionMoveToLocation(GetLocation(GetWaypointByTag("WP_vampstation")),TRUE));
    }
}

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    string sTemplate;
    location lLoc;
    if(nEvent == 7776)
    {
        sTemplate = GetStringLeft(GetTag(OBJECT_SELF),8);
        lLoc = GetLocation(OBJECT_SELF);
        DelayCommand(30.0, SpawnVampire(sTemplate, lLoc));
    }
}

