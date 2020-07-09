
void main()
{
    object oClicker = GetClickingObject();
    object oTarget;
    //Teygan plots active
    if(GetLocalInt(GetModule(),"teygan_start") ==2)
    {
        oTarget=GetWaypointByTag("wp_ar1401");
    }
    else
    {
        oTarget=GetWaypointByTag("wp_ar1401a");
    }

    SetAreaTransitionBMP(AREA_TRANSITION_MINES_05);

    AssignCommand(oClicker,JumpToObject(oTarget));
}
