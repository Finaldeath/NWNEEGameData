void main()
{
   object oPC = GetEnteringObject();
   if (GetIsPC(oPC) &&
       !GetLocalInt(OBJECT_SELF,"pm_endgame_fired") &&
       GetLocalInt(GetModule(),"pm_endgame_start") == 1)
       {
       SetLocalInt(OBJECT_SELF,"pm_endgame_fired",1);
       ExecuteScript("hf_tu_spawn",OBJECT_SELF);
       }
}
