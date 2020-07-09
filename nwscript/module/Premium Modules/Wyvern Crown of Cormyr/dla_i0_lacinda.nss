////////////////////////////////////////////////////////////////////////////////
// dla_i0_lacinda - Handles issues with Lacinda's horse and it's Stalking nature
// Scripted By: Deva B. Winblood   8/10/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"


//////////////////////////////////////////
// PROTOTYPES
//////////////////////////////////////////

// FILE: dla_i0_lacinda
// This function gives the horse that Lacinda owns to the PC.
void DLA_GiveLacindasHorse(object oPC);



//////////////////////////////////////////
// FUNCTIONS
//////////////////////////////////////////


void LacDebug(string sMsg)
{ // PURPOSE: Debug message
    if (!GetLocalInt(GetModule(),"bDebugOff")) SendMessageToPC(GetFirstPC(),sMsg);
} // LacDebug()

void privateDLA_DestroyLacindasHorse()
{ // PURPOSE: This will make sure there are no Lacinda's horses in this module
  // Scripted By: Deva B. Winblood   8/10/2006
     int nN=0;
     object oHorse=GetObjectByTag("LacHorse",nN);
     LacDebug("   privateDLA_DestroyLacindasHorse()");
     while(GetIsObjectValid(oHorse))
     { // destroy all LacHorse instances
         AssignCommand(oHorse,SetIsDestroyable(TRUE,FALSE,FALSE));
         DelayCommand(0.5,DestroyObject(oHorse));
         LacDebug("     Destroyed #:"+IntToString(nN+1));
         nN++;
         oHorse=GetObjectByTag("LacHorse",nN);
     } // destroy all LacHorse instances
} // privateDLA_DestroyLacindasHorse()



void privateDLA_MakeMountedHorsePCs(object oPC,object oMountedBy)
{ // PURPOSE: creates a horse in __IGNORE area that is stored.  It then
  // changes variables as appropriate on oMountedBy so it will restore it
  // properly upon dismount
  // Scripted By: Deva B. Winblood   8/10/2006
    object oWP=GetWaypointByTag(DLA_UNMOUNTED_MOUNT_MOVE);
    object oHorse=CreateObject(OBJECT_TYPE_CREATURE,"dla_hvywarhorse3",GetLocation(oWP));
    LacDebug("    privateDLA_MakeMountedHorsePCs("+GetName(oPC)+","+GetName(oMountedBy)+")");
    SetLocalObject(oHorse,"oDLAMyMaster",oMountedBy);
    SetLocalObject(oHorse,"oDLA_HORSE_OWNER",oPC);
    SetLocalString(oMountedBy,"sHorseTag","dla_hvywarhorse3");
    SetLocalObject(oMountedBy,"oDLAMyMount",oHorse);
    SetLocalObject(oMountedBy,"oDLA_HORSE_OWNER",oPC);
    DeleteLocalInt(oMountedBy,"bLacindasOwnedHorse");
    SetLocalInt(oHorse,"bStored",TRUE);
    AssignCommand(oHorse,ClearAllActions(TRUE));
    SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHorse);
    SetAILevel(oHorse,AI_LEVEL_LOW);
    SetCommandable(FALSE,oHorse);
    DelayCommand(0.1,privateDLA_DestroyLacindasHorse());
} // privateDLA_MakeMountedHorsePCs()



void DLA_GiveLacindasHorse(object oPC)
{ // PURPOSE: To set Lacinda's Horse to be the PC's horse
    int nN=1;
    object oHorse=GetObjectByTag("LacHorse");
    object oHench;
    object oCopy;
    effect eGhost=EffectCutsceneGhost();
    LacDebug("DLA_GiveLacindasHorse(): oHorse='"+GetName(oHorse)+"'");
    if (GetLocalInt(GetModule(),"bLacHorseGiven"))
    { // already given
        LacDebug("   Horse already given... this instance aborted.");
        return;
    } // already given
    SetLocalInt(GetModule(),"bLacHorseGiven",TRUE);
    if (GetIsObjectValid(oHorse))
    { // horse exists
            LacDebug("  Horse Exists");
            // Bill Harper 20/01/27 - Creating a new horse more reliable than copying
            oCopy = CreateObject(OBJECT_TYPE_CREATURE,"dla_hvywarhorse3",GetLocation(oHorse),FALSE,"dla_hvywarhorse3");
            //oCopy=CopyObject(oHorse,GetLocation(oPC),OBJECT_INVALID,"dla_hvywarhorse3");
            //ChangeToStandardFaction(oCopy,STANDARD_FACTION_COMMONER);
            DLA_SetHenchman(oCopy,oPC);
            SetName(oCopy,GetName(oPC)+"'s Heavy Warhorse");
            LacDebug("  Copy Created:'"+GetName(oCopy)+ ", with Tag: " +GetTag(oCopy)+"'");
            DLA_RemoveHenchman(GetMaster(oHorse),oHorse);
            DeleteLocalString(oHorse,"DLA_TAG_HORSE_NPC_OWNER");
            SetLocalObject(oHorse,"oDLA_HORSE_OWNER",oPC);
            DeleteLocalInt(oHorse,"bLacindasOwnedHorse");
            SetLocalObject(oHorse,"oDLAMyMaster",oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eGhost,oHorse,2.0);
            DestroyObject(oHorse);
            DelayCommand(0.1,privateDLA_DestroyLacindasHorse());
    } // horse exists
    else
    { // must be mounted
        LacDebug("  Look for mounted version.");
        if (DLA_GetIsMounted(oPC)&&(GetLocalString(oPC,"sHorseTag")=="LacHorse"||GetLocalInt(oPC,"bLacindasOwnedHorse")))
        { // PC is riding Lacinda's
            LacDebug("     PC is riding Lacinda's horse.");
            privateDLA_MakeMountedHorsePCs(oPC,oPC);
            DelayCommand(0.1,privateDLA_DestroyLacindasHorse());
        } // PC is riding Lacinda's
        else
        { // find henchman mounter
            oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
            while(GetIsObjectValid(oHench))
            { // find Lacinda's horse - who is riding it?
                LacDebug("     henchman: '"+GetName(oHench)+"'");
                if (DLA_GetIsMounted(oHench)&&(GetLocalString(oHench,"sHorseTag")=="LacHorse"||GetLocalInt(oPC,"bLacindasOwnedHorse")))
                { // this henchman is riding it
                    LacDebug("        Mounted on Lacinda's Horse.");
                    privateDLA_MakeMountedHorsePCs(oPC,oHench);
                    DelayCommand(0.1,privateDLA_DestroyLacindasHorse());
                    return;
                } // this henchman is riding it
                nN++;
                oHench=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
            } // find Lacinda's horse - who is riding it?
            // the horse does not appear to exist - create it
            LacDebug("  LacHorse could not be found... create it.");
            oHorse=CreateObject(OBJECT_TYPE_CREATURE,"dla_hvywarhorse3",GetLocation(oPC),FALSE,"dla_hvywarhorse3");
            SetLocalObject(oHorse,"oDLA_HORSE_OWNER",oPC);
            SetLocalObject(oHorse,"oDLAMyMaster",oPC);
            DLA_SetHenchman(oHorse,oPC);
            SetName(oHorse,GetName(oPC)+"'s Heavy Warhorse");
        } // find henchmen mounter
    } // must be mounted
} // DLA_GiveLacindasHorse()


//void main(){}
