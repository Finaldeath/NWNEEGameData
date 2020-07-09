////////////////////////////////////////////////////////////////////////////////
// dla_it_debugdump - used for debugging information for testers
// Original Scripter:  Deva B. Winblood
// Last Modified By:   Deva B. Winblood  7/30/2006
////////////////////////////////////////////////////////////////////////////////

#include "dla_i0_horse"

void fnReport(object oPC,string sMsg)
{ // PURPOSE: output to screen and log
  SendMessageToPC(oPC,sMsg);
  PrintString(sMsg);
} // fnReport()


void main()
{
    object oPC=GetItemActivator();
    object oTarget=GetItemActivatedTarget();
    location lTarget=GetItemActivatedTargetLocation();
    object oOb;
    int nN;
    string sS;
    vector vVec;
    if (oTarget!=OBJECT_INVALID)
    { // specific target specified
      fnReport(oPC,"+---------------------------+");
      fnReport(oPC,"| DETAILED INFORMATION DUMP |");
      fnReport(oPC,"+---------------------------+");
      fnReport(oPC,"OBJECT TARGETED:"+GetName(oTarget)+"  ResRef:'"+GetResRef(oTarget)+"' Tag:'"+GetTag(oTarget)+"'");
      vVec=GetPosition(oTarget);
      oOb=GetArea(oTarget);
      fnReport(oPC,"LOCATION: "+GetName(oOb)+" Tag:"+GetTag(oOb)+"  X:"+FloatToString(vVec.x)+",Y:"+FloatToString(vVec.y)+",Z:"+FloatToString(vVec.z));
      nN=1;
      oOb=GetNearestObject(OBJECT_TYPE_ALL,oTarget,nN);
      fnReport(oPC,"[ NEARBY OBJECTS ]");
      while(oOb!=OBJECT_INVALID&&nN<=10)
      { // display up to 10 objects
        fnReport(oPC,"#"+IntToString(nN)+": "+GetName(oOb)+" ResRef:"+GetResRef(oOb)+"  Tag:"+GetTag(oOb)+" Distance:"+FloatToString(GetDistanceBetween(oOb,oTarget)));
        nN++;
        oOb=GetNearestObject(OBJECT_TYPE_ALL,oTarget,nN);
      } // display up to 10 objects
      fnReport(oPC,"=====MOUNT INFORMATION======");
      fnReport(oPC,"APPEARANCE:"+IntToString(GetAppearanceType(oTarget)));
      fnReport(oPC,"TAIL:"+IntToString(GetCreatureTailType(oTarget)));
      fnReport(oPC,"PHENOTYPE:"+IntToString(GetPhenoType(oTarget)));
      fnReport(oPC,"=====HENCHMAN INFORMATION====");
      sS="Not an associate";
      nN=GetAssociateType(oTarget);
      if (nN==ASSOCIATE_TYPE_HENCHMAN) sS="Henchman";
      else if (nN==ASSOCIATE_TYPE_FAMILIAR) sS="Familiar";
      else if (nN==ASSOCIATE_TYPE_ANIMALCOMPANION) sS="Animal Companion";
      else if (nN==ASSOCIATE_TYPE_SUMMONED) sS="Summoned";
      else if (nN==ASSOCIATE_TYPE_DOMINATED) sS="Dominated";
      fnReport(oPC,"Associate Type: "+sS);
      fnReport(oPC,"Master: "+GetName(GetMaster(oTarget)));
      fnReport(oPC,"oDLAMyMount: "+GetName(GetLocalObject(oTarget,"oDLAMyMount")));
      fnReport(oPC,"sDLA_Horse: "+GetLocalString(oTarget,"sDLA_Horse"));
      fnReport(oPC,"bLacindasOwnedHorse: "+IntToString(GetLocalInt(oTarget,"bLacindasOwnedHorse")));
      fnReport(oPC,"oDLAHorseAssigned: "+GetName(GetLocalObject(oTarget,"oDLAHorseAssigned")));
      fnReport(oPC,"oAssigned: "+GetName(GetLocalObject(oTarget,"oAssigned")));
      fnReport(oPC,"DLA_TAG_HORSE_NPC_OWNER: "+GetLocalString(oTarget,"DLA_TAG_HORSE_NPC_OWNER"));
      fnReport(oPC,"oDLA_HORSE_OWNER: "+GetName(GetLocalObject(oTarget,"oDLA_HORSE_OWNER")));
      fnReport(oPC,"nID: "+IntToString(GetLocalInt(oTarget,"nID")));
      fnReport(oPC,"dla_hitch: "+GetName(GetLocalObject(oTarget,"dla_hitch")));
      sS="Default";
      nN=GetAILevel(oTarget);
      if (nN==AI_LEVEL_HIGH) sS="High";
      else if (nN==AI_LEVEL_INVALID) sS="Invalid";
      else if (nN==AI_LEVEL_LOW) sS="Low";
      else if (nN==AI_LEVEL_NORMAL) sS="Normal";
      else if (nN==AI_LEVEL_VERY_HIGH) sS="Very High";
      else if (nN==AI_LEVEL_VERY_LOW) sS="Very Low";
      fnReport(oPC,"AI LEVEL: "+sS);
      fnReport(oPC,"oDLAMyMaster: "+GetName(GetLocalObject(oTarget,"oDLAMyMaster")));
      fnReport(oPC,"[=== END OF REPORT ===]");
    } // specific target specified
    else
    { // go off of location
      fnReport(oPC,"+---------------------------+");
      fnReport(oPC,"| DETAILED INFORMATION DUMP |");
      fnReport(oPC,"+---------------------------+");
      oOb=GetAreaFromLocation(lTarget);
      vVec=GetPositionFromLocation(lTarget);
      fnReport(oPC,"LOCATION: "+GetName(oOb)+" Tag:"+GetTag(oOb)+"  X:"+FloatToString(vVec.x)+",Y:"+FloatToString(vVec.y)+",Z:"+FloatToString(vVec.z));
      nN=1;
      oOb=GetNearestObjectToLocation(OBJECT_TYPE_ALL,lTarget,nN);
      fnReport(oPC,"[ NEARBY OBJECTS ]");
      while(oOb!=OBJECT_INVALID&&nN<=10)
      { // display up to 10 objects
        fnReport(oPC,"#"+IntToString(nN)+": "+GetName(oOb)+" ResRef:"+GetResRef(oOb)+"  Tag:"+GetTag(oOb)+" Distance:"+FloatToString(GetDistanceBetweenLocations(GetLocation(oOb),lTarget)));
        nN++;
        oOb=GetNearestObjectToLocation(OBJECT_TYPE_ALL,lTarget,nN);
      } // display up to 10 objects
      fnReport(oPC,"=== STORED HORSE INFORMATION ===");
      oTarget=GetWaypointByTag("WP_HORSE_MOUNT_DUMMY");
      nN=1;
      oOb=GetNearestObject(OBJECT_TYPE_CREATURE,oTarget,nN);
      while(GetIsObjectValid(oOb))
      { // check all creatures in the area
          if (DLA_GetIsDLAHorse(oOb))
          { // horse
              fnReport(oPC,"Name: "+GetName(oOb)+"  Master: "+GetName(GetMaster(oOb))+" oDLAMyMaster: "+GetName(GetLocalObject(oOb,"oDLAMyMaster")));
          } // horse
          nN++;
          oOb=GetNearestObject(OBJECT_TYPE_CREATURE,oTarget,nN);
      } // check all creatures in the area
      fnReport(oPC,"=== Count horses with tag LacHorse ===");
      nN=0;
      oOb=GetObjectByTag("LacHorse",nN);
      while(GetIsObjectValid(oOb))
      { // count
          fnReport(oPC,"#"+IntToString(nN+1)+" In Area: "+GetName(GetArea(oOb)));
          nN++;
          oOb=GetObjectByTag("LacHorse",nN);
      } // count
      fnReport(oPC,"[=== END OF REPORT ===]");
    } // go off of location
}
