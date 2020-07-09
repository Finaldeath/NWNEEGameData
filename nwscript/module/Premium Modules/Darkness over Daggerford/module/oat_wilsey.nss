
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  object oGuard=GetNearestObjectByTag("db_lh_militia");
  //if the guard has added his input to the vampire plot
  //remove him from the area
  if(GetLocalInt(GetModule(),"rab_plot")==30)
  {
    DestroyObject(oGuard,5.0);
  }
  SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
  AssignCommand(oClicker,JumpToObject(oTarget));
}
