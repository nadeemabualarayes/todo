import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todotask/utils/colors.dart';

class CalenderPage extends StatefulWidget {
  static const String id = '/CalenderPage';

  const CalenderPage({Key key}) : super(key: key);

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  initState() {
    super.initState();
    goToCalender();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: kWhiteColor),
          elevation: 2,
          title: const Text(
            'Calender',
            style: TextStyle(color: kWhiteColor, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: kBackgroundColor,
        ),
        backgroundColor: kBackgroundColor,
        body:
            SafeArea(child: OrientationBuilder(builder: (context, orientation) {
          return LayoutBuilder(builder: (context, constraints) {
            return SfCalendar(
              viewHeaderStyle: ViewHeaderStyle(
                backgroundColor: kBackgroundColor,
                dayTextStyle: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    color: kPurpleColor,
                    fontWeight: FontWeight.bold),
                dateTextStyle: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 16,
                    color: kPurpleColor,
                    fontWeight: FontWeight.bold),
              ),
              todayTextStyle: TextStyle(
                color: kWhiteColor,
                fontSize: MediaQuery.of(context).textScaleFactor * 15,
              ),
              todayHighlightColor: kPurpleColor,
              headerStyle: CalendarHeaderStyle(
                backgroundColor: kBackgroundColor,
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: kWhiteColor,
                  fontSize: orientation == Orientation.landscape &&
                          constraints.maxWidth > 500
                      ? 0.02 * constraints.maxWidth
                      : 0.05 * constraints.maxWidth,
                ),
              ),
              headerHeight: displayScreenHeight(context) * 0.08,
              view: CalendarView.month,
              showNavigationArrow: true,
              showDatePickerButton: true,
              // dataSource: EventCalendarDataSource(
              //     Provider.of<DataSync>(context, listen: false)
              //         .adminListOfCalendarDataGetter),
              monthViewSettings: MonthViewSettings(
                  showTrailingAndLeadingDates: false,
                  agendaStyle: AgendaStyle(
                      appointmentTextStyle: TextStyle(
                          color: kPurpleColor,
                          fontSize: MediaQuery.of(context).textScaleFactor * 15,
                          fontWeight: FontWeight.bold),
                      dayTextStyle: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 15,
                          fontWeight: FontWeight.bold,
                          color: kPurpleColor),
                      dateTextStyle: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 15,
                          fontWeight: FontWeight.bold,
                          color: kPurpleColor),
                      backgroundColor: kBackgroundColor),
                  monthCellStyle: MonthCellStyle(
                    backgroundColor: kBackgroundColor,
                    todayBackgroundColor: kBackgroundColor,
                    trailingDatesBackgroundColor: kBackgroundColor,
                    leadingDatesBackgroundColor: kBackgroundColor,
                    textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 15,
                        color: kWhiteColor),
                  ),
                  agendaViewHeight: displayScreenHeight(context) * 0.45,
                  appointmentDisplayCount: 4,
                  numberOfWeeksInView: 4,
                  showAgenda: true,
                  dayFormat: 'EE',
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.indicator),
              cellBorderColor: kBackgroundColor,
            );
          });
        })));
  }

  void goToCalender() async {}
}
