// February 2006
// B W-Husey
// Move henchman back to their location.
// Modified by Deva B. Winblood   Jun 18, 2006 - to address Mantis #1697
// Modified by Deva B. Winblood   Jul 29, 2006 - to address Mantis #1910 and others

#include "dla_i0_horse"
void main()
{
    string sName = GetTag(OBJECT_SELF);
    location lLoc = GetLocation(GetWaypointByTag("Hench_"+sName));
    object oHorseHitchWP=GetWaypointByTag("WP_lachorsestand");
    object oLacinda=OBJECT_SELF;
    object oHorse=GetObjectByTag("LacHorse");
    object oMaster;
    int nN;
    if (GetIsObjectValid(oHorse)&&GetTag(oLacinda)=="Lacinda")
    { // horse exists
         oMaster=GetLocalObject(oHorse,"oDLAMyMaster");
         if (oMaster!=oLacinda&&DLA_GetIsMounted(oMaster)&&GetLocalObject(oMaster,"oDLAMyMount")==oHorse)
         { // someone else riding dismount
            // DLA_Dismount(oMaster,FALSE,TRUE,FALSE,GetPCSpeaker());
            //*
            DLA_Dismount(oMaster,FALSE,TRUE,FALSE,oLacinda);
         } // someone else riding dismount
         DelayCommand(5.5,DestroyObject(oHorse)); // Destroy the horse per #1910
         //*
    } // horse exists
    else if (GetTag(oLacinda)=="Lacinda")
    { // check to see if someone is mounting her horse
        oMaster=GetFirstPC();
        if (DLA_GetIsMounted(oMaster)&&GetLocalString(oMaster,"sHorseTag")=="LacHorse")
        { // dismount and destroy
            SetLocalInt(oMaster,"bDismountDestroy",TRUE);
            DLA_Dismount(oMaster,TRUE,FALSE,FALSE,oLacinda);
        } // dismount and destroy
        else
        { // check henchmen
            nN=1;
            oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster,nN);
            while(GetIsObjectValid(oHorse))
            { // check henchmen
                if (DLA_GetIsMounted(oHorse)&&GetLocalString(oMaster,"sHorseTag")=="LacHorse")
                { // dismount and destroy
                    SetLocalInt(oHorse,"bDismountDestroy",TRUE);
                    DLA_Dismount(oHorse,TRUE,FALSE,FALSE,oLacinda);
                } // dismount and destroy
                nN++;
                oHorse=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oMaster,nN);
            } // check henchmen
        } // check henchmen
    } // check to see if someone is mounting her horse
    SetAILevel(oLacinda,AI_LEVEL_NORMAL);
    if (DLA_GetIsMounted(oLacinda))
    { // move to where to hitch the horse
       AssignCommand(oLacinda,ClearAllActions(TRUE));
       AssignCommand(oLacinda,ActionMoveAwayFromObject(GetPCSpeaker(),TRUE,10.0));
       if (GetTag(oLacinda)=="Lacinda") AssignCommand(oLacinda,ActionJumpToObject(oHorseHitchWP));
       if (GetLocalString(oLacinda,"sHorseTag")=="LacHorse") AssignCommand(oLacinda,ActionDoCommand(DLA_Dismount(oLacinda,FALSE,FALSE,FALSE,oLacinda)));
       else { AssignCommand(oLacinda,ActionDoCommand(DLA_Dismount(oLacinda,FALSE,TRUE)));  }
       AssignCommand(oLacinda,ActionDoCommand(DelayCommand(5.0,JumpToLocation(lLoc))));
       AssignCommand(oLacinda,ActionDoCommand(SetAILevel(oLacinda,AI_LEVEL_DEFAULT)));
       AssignCommand(oLacinda,ActionDoCommand(DLA_RemoveHenchman(GetMaster(oLacinda),oLacinda)));
    } // move to where to hitch the horse
    else
    { // not mounted
      AssignCommand(oLacinda,ClearAllActions(TRUE));
      AssignCommand(oLacinda,ActionMoveAwayFromObject(GetPCSpeaker()));
      AssignCommand(oLacinda,DelayCommand(5.0,JumpToLocation(lLoc)));
      AssignCommand(oLacinda,ActionDoCommand(SetAILevel(oLacinda,AI_LEVEL_DEFAULT)));
      AssignCommand(oLacinda,ActionDoCommand(DLA_RemoveHenchman(GetMaster(oLacinda),oLacinda)));
    } // not mounted

    if (GetIsObjectValid(oHorse)&&GetTag(oLacinda)=="Lacinda")
    { // take care of this horse
         DelayCommand(5.6,DestroyObject(oHorse));
    } // take care of this horse

}
