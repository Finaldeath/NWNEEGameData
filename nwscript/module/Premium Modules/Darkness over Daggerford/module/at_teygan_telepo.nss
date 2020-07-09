//Sememmon teleports the PC away
//and then despawns as the player decided not side with him
void main()
{
    object oPC = GetPCSpeaker();
    object oTeygan = GetObjectByTag("Teygan");
    location lPC1 = GetLocation(oPC);
    location lPC2 = GetLocation(GetWaypointByTag("wp_pc_sememmon_teleport"));
    //effect eParalyze = EffectCutsceneParalyze();
    effect eMagic = EffectVisualEffect(VFX_FNF_PWKILL);
    //paralyze and teleport the pc
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eParalyze,oPC,2.8);
    //Int set for cave transition
    SetLocalInt(GetModule(), "teygan_start", 4);
    AssignCommand(oTeygan,PlayAnimation(ANIMATION_LOOPING_CONJURE2,1.0,3.0));
    DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eMagic,lPC1));
    DelayCommand(3.0,AssignCommand(oPC,JumpToLocation(lPC2)));
    //set an int to say that PC has chosen good route
    //not requred in final mod version (removd 12 feb 06)
    //SetLocalInt(GetModule(),"good_evil",1);
}
