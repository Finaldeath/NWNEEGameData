//Iyrauroth OnDeath handler
void main()
{
    SignalEvent(GetNearestObjectByTag("DeadIyrauroth"), EventUserDefined(4001));
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
