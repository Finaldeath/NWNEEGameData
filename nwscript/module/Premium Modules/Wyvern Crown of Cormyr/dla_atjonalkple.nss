// January 2006
// B W-Husey
// Generic use forceful conversation animation (so it doesn't run for ever.)

void main()
{
AssignCommand(GetNearestObjectByTag("Jonas"),ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,2.0));
}
