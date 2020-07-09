
#include "dla_i0_horse"
#include "dla_i0_horseai"
#include "cu_functions"
void main()
{
  object oPC = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  object oArea = GetArea(oTarget);
  object oHitchingPost = GetNearestObjectByTag(DLA_TAG_HITCHING_POST);
  int bWarned;
  float fDelay=0.0f;

  if(GetLocalInt(oPC,"nTransitionDelay"))
  {
    return;
  }

  string sShy = "You must dismount before entering this area";

  string sShyOverride = GetLocalString(oArea,"sHorseShyOverride");
  if(sShyOverride!="")
  {
    sShy = sShyOverride;
  }

  if(!DLA_GetIsInteriorAllowed(oArea))
  {
    if (DLA_GetIsMounted(oPC))
    {
       FloatingTextStringOnCreature(sShy, oPC, FALSE);
       DLA_Dismount(oPC, TRUE, FALSE, TRUE);
       bWarned = TRUE;
    }
    if (DLA_RemoveAllHenchmenHorses(oPC, oHitchingPost) && !bWarned )
    {
       FloatingTextStringOnCreature("Horses are now tied to nearby hitching post", oPC, FALSE);
       SetLocalInt(oPC,"nTransitionDelay",TRUE);
       fDelay = 2.0f;
       DelayCommand(fDelay,DeleteLocalInt(oPC,"nTransitionDelay"));
    }
    if(bWarned)
    {
        return;
    }
  }

  DelayCommand(fDelay, AssignCommand(oPC,JumpToObject(oTarget)));
  DelayCommand(fDelay+0.1, DLA_SetAreaTransCameraFacing(oPC,oTarget));
}
