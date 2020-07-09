void main()
{
     object oController = GetNearestObjectByTag("IllusionController");
     SignalEvent(oController, EventUserDefined(4501));
}
