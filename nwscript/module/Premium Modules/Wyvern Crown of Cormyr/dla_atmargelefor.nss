// January 2006
// B W-Husey
// Eleanor use forceful conversation animation (so it doesn't run for ever.)

void main()
{
    AssignCommand(GetNearestObjectByTag("Eleanor"),ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,3.0));
}
