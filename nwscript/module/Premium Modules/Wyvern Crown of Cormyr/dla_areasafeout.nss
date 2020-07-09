// October 2005
// B W-Husey
// This is a generic OnEnter script for an area, used for safe outside area. It checks the weather and sets up
// the environment dependant on that.
#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))DelayCommand(0.1,CheckWeather(GetArea(oPC),oPC));
}
