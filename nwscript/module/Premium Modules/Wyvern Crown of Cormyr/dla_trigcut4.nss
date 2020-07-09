//March 2006
// B W-Husey
// This cutscene handles the dialogue with Wyvervapor

#include "cu_functions"
#include "cu_cameras"
#include "cu_cutscenes"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    //location lSpawn = GetLocation(GetWaypointByTag("WP_SpawnWV"));
    if (GetIsDefPC(oPC))
    {
        MusicBackgroundChangeDay(oArea,68);
        MusicBackgroundChangeNight(oArea,68);
        object oDrag = GetLocalObject(oPC,"oKludgeFactor10");
        AssignCommand(oPC,ActionStartConversation(oDrag,"wyvernvapor",FALSE,FALSE));
        //object oForce = CreateObject(OBJECT_TYPE_PLACEABLE,"dla_forcetalk",GetLocation(oPC));
        //SetLocalObject(oForce,"oForceTalk1",oPC);
        //SetLocalObject(oForce,"oForceTalk2",oDrag);
        DestroyObject(OBJECT_SELF,0.5);
    }
}
