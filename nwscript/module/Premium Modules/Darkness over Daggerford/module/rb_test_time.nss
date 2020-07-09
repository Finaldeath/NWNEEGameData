void main()
{
    int nHour = GetTimeHour() + 8;
    SetTime(nHour, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());
}
