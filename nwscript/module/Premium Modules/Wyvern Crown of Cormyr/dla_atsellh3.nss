////////////////////////////////////////////////////////////////////////////////
// dla_atsellh3 - Wangle buy's a horse from the PC
// Scripted By: Deva B. Winblood   8/3/2006
////////////////////////////////////////////////////////////////////////////////
#include "dla_i0_horse"

void main()
{
    object oWangle=OBJECT_SELF;
    object oBoy;
    object oHorse=GetLocalObject(oWangle,"oInterested");
    object oBoySpawn=GetWaypointByTag("WP_STABLEBOY_SPAWN");
    object oBoyLeave=GetWaypointByTag("WP_STABLEBOY_LEAVE");
    object oCopy;
    int nValue=GetLocalInt(oWangle,"nSellPrice");
    effect eInvis=EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect eGhost=EffectCutsceneGhost();
    GiveGoldToCreature(GetPCSpeaker(),nValue);
    oCopy=CopyObject(oHorse,GetLocation(oHorse));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eInvis,oHorse);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eGhost,oHorse);
    oBoy=CreateObject(OBJECT_TYPE_CREATURE,"nw_malekid01",GetLocation(oBoySpawn),FALSE);
    AddHenchman(oBoy,oCopy);
    DLA_RemoveHenchman(GetMaster(oHorse),oHorse,TRUE,FALSE);
    AssignCommand(oBoy,ActionForceMoveToObject(oCopy,TRUE,1.0,18.0));
    AssignCommand(oBoy,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0));
    AssignCommand(oBoy,ActionDoCommand(AssignCommand(oCopy,ClearAllActions(TRUE))));
    AssignCommand(oBoy,ActionDoCommand(AssignCommand(oCopy,ActionForceFollowObject(oBoy,1.5))));
    AssignCommand(oBoy,ActionDoCommand(SetCommandable(FALSE,oCopy)));
    AssignCommand(oBoy,ActionMoveToObject(oBoyLeave,TRUE));
    AssignCommand(oBoy,ActionDoCommand(DestroyObject(oCopy)));
    AssignCommand(oBoy,ActionDoCommand(DestroyObject(oBoy)));
    AssignCommand(oBoy,SetCommandable(FALSE,oBoy));
    DelayCommand(3.0,DLA_DespawnPaladinMount(oHorse));
    DelayCommand(60.1,DestroyObject(oHorse));
    DelayCommand(60.0,DestroyObject(oBoy));

}
