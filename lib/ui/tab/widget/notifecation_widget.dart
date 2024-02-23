import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_todo/cubit/notifacation/notifacition_cubit.dart';
import 'package:task_todo/utils/images.dart';

class NotifacationWidget extends StatelessWidget {
  const NotifacationWidget(
      {super.key, required this.taskName, required this.taskTime});
  final String taskName;
  final String taskTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin:
              Alignment.topRight, // Yukarıdan başlasın ve sağa doğru ilerlesin
          end: Alignment.bottomRight,

          colors: [
            const Color(0xFF81C7F5),
            const Color(0xFF3867D5).withOpacity(0.8),
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.centerRight, // Yönlendirme değişti
              end: Alignment.bottomRight, // Yönlendirme değişti
              colors: [
                Color(0xFF94beef),
                Color(0xFF97c2f1), // Sağ üst
                // Sol alt
              ],
              stops: [0.0, 1.0],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'Today Reminder',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          taskName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          taskTime,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        context.read<NatifacitionCubit>().closeNotifacition();
                      },
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: SvgPicture.asset(AppSvg.close)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(
                        height: 82,
                        width: 62,
                        child: Image.asset(AppImages.bell)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
