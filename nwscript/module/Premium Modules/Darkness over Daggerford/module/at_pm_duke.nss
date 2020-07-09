//As part of the conversation bw_duke
//we need to set a module variable to enable the following
//allow use of secret entry via cemetery to castle
//change the speakstrings the commoners have in town.
//spawn the orcs in town
//
//Author: Phil Mitchell (Baron of Gateford)
void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(GetModule(),"pm_endgame_start",1);
}
