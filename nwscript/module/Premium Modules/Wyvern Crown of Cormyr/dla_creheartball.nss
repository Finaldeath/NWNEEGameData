// Pctpber 2005
// B W-Husey
// Heartbeat script for ballista firers.
#include "x0_i0_petrify"
#include "x0_i0_anims"
#include "cu_functions"
void main()
{
/*    if (GetLocalInt(OBJECT_SELF,"Active")==1) //heartbeat switched on by perception.
    {
    if (Random(3)!=0) //doesn't fire every time to reduce shots.
    {
    PlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
    DelayCommand(2.2,ClearAllActions());
    DelayCommand(2.5,ActionInteractObject(GetNearestObjectByTag("Ballista")));
    }
    }*/

//    object oNearest = GetNearestObject(OBJECT_TYPE_CREATURE);
    object oNearest = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);


        if (GetHasEffect(EFFECT_TYPE_SLEEP)&& GetLocalInt(OBJECT_SELF,"nPerceive")==1)
        {
            object oPC = GetLastPerceived();
            if(GetIsEnemy(oPC))
            {
                SetLocalInt(OBJECT_SELF,"nPerceive",0);  //one wake check, after this stone deaf.
                // ********debug line**************
//                SendMessageToPC(GetFirstPC(),"HB peception says listen");
                if (GetSkillCheckSucceeded(OBJECT_SELF,SKILL_LISTEN,20))
                {
//               effect eEffect;
//               eEffect = GetFirstEffect(OBJECT_SELF);
//                while(GetIsEffectValid(eEffect))
//                {
//                     if (GetEffectType(eEffect) == EFFECT_TYPE_SLEEP)
//                     {
                     //Remove the effect
//                     DelayCommand(5.0,RemoveEffect(OBJECT_SELF, eEffect));
                       DelayCommand(5.0,RemoveEffectOfType(OBJECT_SELF, EFFECT_TYPE_SLEEP));
//                     }
//                 eEffect = GetNextEffect(OBJECT_SELF);
//                 }
                }
                else
                {
                           effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
                           DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF));
                           DelayCommand(25.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF));
                }
            }
        }

    //Default script to fire ballista
    else if (GetIsEnemy(oNearest) && GetDistanceToObject(oNearest)<5.0)  //There are no friends between me and my enemy and he's less than 10 metres away...
        {
        ExecuteScript("x2_def_heartbeat", OBJECT_SELF);
        }
    else if (GetIsEnemy(oNearest) && GetDistanceToObject(oNearest)<50.0)
            {
            ClearAllActions(TRUE);
    if (Random(3)!=0) //doesn't fire every time to reduce shots.
    {
    //***Debug Line*****
//    SendMessageToPC(GetFirstPC(),"heartbeat says fire");
    object oBal = GetNearestObjectByTag("Ballista");
    PlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
    AssignCommand(oBal,DelayCommand(0.5,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)));
    DelayCommand(2.2,ClearAllActions());
    DelayCommand(2.5,ActionInteractObject(oBal));
    }

//            SetCommandable(FALSE,OBJECT_SELF);           //Stop DetermineCombatRound() overiding flee orders
//            DelayCommand(5.0,SetCommandable(TRUE,OBJECT_SELF));
            }
}
