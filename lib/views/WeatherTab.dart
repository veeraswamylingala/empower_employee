import 'package:empower_employees/models/WeatherModel.dart';
import 'package:empower_employees/repositories/WeathrRepo.dart';
import 'package:empower_employees/views/WidgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';

class WeatherTab extends StatefulWidget {
  const WeatherTab({
    super.key,
  });

  @override
  State<WeatherTab> createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  String errorMessage = "ERROR";
  WeatherRepo weatherRepo = WeatherRepo();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherRepo.fetchWeatherInfo(), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: loadingWidget());
          default:
            if (snapshot.hasError) {
              return Center(
                child: errorWidget(
                    context: context, errorMessage: snapshot.error.toString()),
              );
            } else {
              if (snapshot.data != null) {
                WeatherModel weatherData = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //show Current weather details
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                weaterIcon(
                                    code: weatherData.current!.weathercode!,
                                    widgetSize: 25),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: weatherData
                                                .current!.temperature2M
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        TextSpan(
                                          text: weatherData
                                              .currentUnits!.temperature2M,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  weaterDescription(
                                      code: weatherData.current!.weathercode!),
                                )
                              ]),
                        ),
                      ),
                      //Show location details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            weatherData.timezone.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.mapPin,
                              ),
                              Text(
                                "${weatherData.latitude.toString()}/${weatherData.longitude.toString()}",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return errorWidget(
                    context: context, errorMessage: errorMessage);
              }
            }
        }
      },
    );
  }

//show icon based on weatherCode
  Widget weaterIcon({required int code, required double widgetSize}) {
    switch (code) {
      case 80:
        return FaIcon(
          FontAwesomeIcons.cloudRain,
          size: widgetSize,
        );
      case 45:
        return FaIcon(
          FontAwesomeIcons.smog,
          size: widgetSize,
        );
      case 3:
        return FaIcon(
          FontAwesomeIcons.cloudSun,
          size: widgetSize,
        );
      default:
        return FaIcon(
          FontAwesomeIcons.sun,
          size: widgetSize,
        );
    }
  }

//show description based on weatherCode
  String weaterDescription({required int code}) {
    switch (code) {
      case 80:
        return "Rain showers: Slight, moderate, and violent";
      case 45:
        return "Fog and depositing rime fog";
      case 3:
        return "Mainly clear, partly cloudy, and overcast";
      default:
        return "Clear sky";
    }
  }

//Format DateTime in our format
  String formatDate(DateTime date) {
    final DateFormat format = DateFormat('dd-MMM-yyyy');
    return format.format(date);
  }
}
