void main()
{
    int nDay = GetCalendarDay();
    nDay += 2;
    SetCalendar(GetCalendarYear(), GetCalendarMonth(), nDay);
}
