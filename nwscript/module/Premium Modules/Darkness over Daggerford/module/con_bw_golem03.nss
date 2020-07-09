void main()
{
    object oLever = GetObjectByTag("ar2503_fire_lever");
    ActionForceMoveToObject(oLever, FALSE, 1.0f, 240.0f);
    ActionInteractObject(oLever);
}
