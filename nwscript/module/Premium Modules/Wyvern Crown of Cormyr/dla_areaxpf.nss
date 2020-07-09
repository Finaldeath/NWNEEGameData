// February 2006
// B W-Husey
// Sets up the 'Careless Master' sidequest.
/*
    1. Any party horses left in the area?
    2. Any guards/are the horses warhorses?
    3. Generate either a dying/dead thief or a bunch of tracks (at instance of last horse checked)
*/

#include "dla_i0_horseai"
#include "dla_i0_horse"

void main()
{
object oPC = GetExitingObject();
object oArea = OBJECT_SELF;
object oThief;
int nInt = GetLocalInt(oArea,"nDefended"); //used to test if this has happened and what happened


if (GetIsPC(oPC) && nInt<1 && GetLocalInt(oPC,"nCareActive")>0) //Is PC, is active, and not done already
{
    // Loop all objects in us, an area
    object oObject = GetFirstObjectInArea(oArea);
    object oHorseOwner;
    location lInstance; //where the event will happen
    location lStolen = GetLocation(GetWaypointByTag("WP_StolenHorse")); // Where stolen horses are placed
    while(GetIsObjectValid(oObject))
    {
         if (DLA_GetIsDLAHorse(oObject))//Is it a horse?
         {
            oHorseOwner = GetLocalObject(oObject, "oDLA_HORSE_OWNER"); //Check the owner
            if (GetIsPC(oHorseOwner) || GetIsPC(GetMaster(oHorseOwner))) //if TRUE this is a party horse
            {
                if (DLA_GetIsTied(oObject)) // Horse is tied to a hitching post, now find it
                {

                    if (DLA_GetIsWarhorse(oObject)) // leave it, and will make a body
                    {
                        SetLocalInt(oArea,"nDefended",1);
                        lInstance = GetLocation(oObject);
                    }
                    else //otherwise take it and will leave tracks.
                    {
                        if (GetLocalInt(oArea,"nDefended")!=1)
                        {
                        SetLocalInt(oArea,"nDefended",2);  //As long as there were no fighting capable party members, set to stolen
                        lInstance = GetLocation(oObject);
                        AssignCommand(oObject,JumpToLocation(lStolen));
                        }
                    }


                } //end of is tied if
            }  //end of check owner if
         }  //end of is horse if
         oObject = GetNextObjectInArea(oArea);
    } //end of while loop
    nInt = GetLocalInt(oArea,"nDefended");
    switch (nInt)
    {
        case 0:  //nothing happened
        break;
        case 1:  // horses could defend themselves
            oThief = CreateObject(OBJECT_TYPE_CREATURE,"dyingthief",lInstance,FALSE);
            AssignCommand(oThief,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,HoursToSeconds(120)));
//            AddJournalQuestEntry("Careless",11,oPC);
        break;
        case 2:  // horses could not defend themselves
            CreateObject(OBJECT_TYPE_PLACEABLE,"tracksthief",lInstance,FALSE);
//            AddJournalQuestEntry("Careless",10,oPC);
        break;
    }

} // end of is PC if
}

