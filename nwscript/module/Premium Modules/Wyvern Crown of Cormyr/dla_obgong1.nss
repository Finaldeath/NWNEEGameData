// B W-Husey
// October 2005
// Remove sleep effects from up to 5 sleepers with the ArtSleep tag when the gong is used.


void main()
{
object oSound = GetNearestObjectByTag("Playsound");
object oSound2 = GetNearestObjectByTag("PlaysoundHorn");

//if you can fix this great. I had to use GetNearest instead.
/*
vector vOrigin = GetPosition(OBJECT_SELF);
location lOrigin = Location(GetArea(OBJECT_SELF),vOrigin,GetFacing(OBJECT_SELF));
object oWaker =  GetFirstObjectInShape(SHAPE_SPHERE,50.0,lOrigin,FALSE,OBJECT_TYPE_CREATURE,vOrigin);
effect eEffect = GetFirstEffect(oWaker);
*/

SoundObjectPlay(oSound);
DelayCommand(5.0,SoundObjectPlay(oSound2));
DelayCommand(10.0,SoundObjectPlay(oSound2));
DelayCommand(17.0,SoundObjectPlay(oSound2));
DelayCommand(3.0,SoundObjectStop(oSound));
DelayCommand(25.0,SoundObjectStop(oSound2));

//Search for sleep effects

/*
while(GetIsObjectValid(oWaker))
{
    if (GetTag(oWaker)=="ArtSleep")
    {
        while(GetIsEffectValid(eEffect))
        {
             if (GetEffectType(eEffect) == EFFECT_TYPE_SLEEP)
             {
             //Remove the effect
             RemoveEffect(oWaker, eEffect);
             }
             eEffect = GetNextEffect(oWaker);
        }
    }
    oWaker =  GetNextObjectInShape(SHAPE_SPHERE,50.0,lOrigin,FALSE,OBJECT_TYPE_CREATURE,vOrigin);
}
*/

object oWaker;
effect eEffect;
int nNum = 5;
while (nNum>0)
{
oWaker = GetNearestObjectByTag("ArtSleep",OBJECT_SELF,nNum);
eEffect = GetFirstEffect(oWaker);
        while(GetIsEffectValid(eEffect))
        {
             if (GetEffectType(eEffect) == EFFECT_TYPE_SLEEP)
             {
             //Remove the effect
             RemoveEffect(oWaker, eEffect);
             }
             eEffect = GetNextEffect(oWaker);
        }
nNum --;
}
oWaker = GetNearestObjectByTag("PFPatrolLeft1",OBJECT_SELF,nNum);
eEffect = GetFirstEffect(oWaker);
        while(GetIsEffectValid(eEffect))
        {
             if (GetEffectType(eEffect) == EFFECT_TYPE_SLEEP)
             {
             //Remove the effect
             RemoveEffect(oWaker, eEffect);
             }
             eEffect = GetNextEffect(oWaker);
        }
oWaker = GetNearestObjectByTag("PFPatrolRight1",OBJECT_SELF,nNum);
eEffect = GetFirstEffect(oWaker);
        while(GetIsEffectValid(eEffect))
        {
             if (GetEffectType(eEffect) == EFFECT_TYPE_SLEEP)
             {
             //Remove the effect
             RemoveEffect(oWaker, eEffect);
             }
             eEffect = GetNextEffect(oWaker);
        }

DelayCommand(2.0,ExecuteScript ("dla_miscdraw",GetObjectByTag("PFDrawBridgeIn"))); //close and lock the drawbridge
}
