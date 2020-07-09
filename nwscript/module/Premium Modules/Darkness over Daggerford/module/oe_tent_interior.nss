void main()
{
    object oFloor=GetNearestObjectByTag("tent_effect");
    PlaySound("as_mg_telepin1");
    SetLocalInt(oFloor,"X2_L_PLC_ACTIVATED_STATE",1);
    //testing section - see if vejoni's combat routiune fires correctly
    //object oPC=GetEnteringObject();
    //if(GetIsPC(oPC))
    //{
    //    SetLocalInt(GetModule(),"vejoni_hasmet",1);
    //    SetLocalInt(GetModule(),"vejoni_plot",25);
    //}
}
