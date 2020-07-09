// November 2005
// B W-Husey
// Old man collapses in fear, later he runs off.

void main()
{
PlayAnimation(ANIMATION_FIREFORGET_SPASM);
DelayCommand(0.5,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,5.0));
ExecuteScript("dla_atoldrun",OBJECT_SELF); //old man flees.
}
