//at_remove_immob
//This script will be placed on the onenter slot of the caravanquarter
//it will be only run the first time the PC enters the area and
//will force the PC to talk to Falias.
//
//Author: Phil Mitchell (Baron of Gateford)
//
void main()
{
   object oPC=GetPCSpeaker();
   //Remove cutsceneimmobilize from the PC
   effect eLoop=GetFirstEffect(oPC);

   while (GetIsEffectValid(eLoop))
       {
       if (GetEffectType(eLoop)==EFFECT_TYPE_CUTSCENE_PARALYZE)
            RemoveEffect(oPC, eLoop);
       eLoop=GetNextEffect(oPC);
       }
SetCutsceneMode(oPC, FALSE);
}

